#!/usr/bin/env python3
import os
import sys


class Parser:
    def __init__(self, vm_path: str):
        self.lines = []
        with open(vm_path, "r", encoding="utf-8") as f:
            for raw in f:
                line = raw.split("//", 1)[0].strip()
                if line:
                    self.lines.append(line)
        self.i = 0
        self.current = None

    def has_more_commands(self) -> bool:
        return self.i < len(self.lines)

    def advance(self) -> None:
        self.current = self.lines[self.i]
        self.i += 1

    def command_type(self) -> str:
        parts = self.current.split()
        if parts[0] == "push":
            return "C_PUSH"
        if parts[0] == "pop":
            return "C_POP"
        return "C_ARITHMETIC"

    def arg1(self) -> str:
        ctype = self.command_type()
        parts = self.current.split()
        if ctype == "C_ARITHMETIC":
            return parts[0]
        return parts[1]

    def arg2(self) -> int:
        parts = self.current.split()
        return int(parts[2])



class CodeWriter:
    def __init__(self, asm_path: str):
        self.out = open(asm_path, "w", encoding="utf-8")
        self.file_name = ""
        self.label_id = 0

    def close(self):
        self.out.close()

    def set_file_name(self, vm_path: str):
        base = os.path.basename(vm_path)
        self.file_name = os.path.splitext(base)[0]

    def write_line(self, s: str):
        self.out.write(s + "\n")

    def write_lines(self, lines):
        self.out.write("\n".join(lines) + "\n")

    def _push_D(self):
        self.write_lines([
            "@SP",
            "A=M",
            "M=D",
            "@SP",
            "M=M+1",
        ])

    def _pop_to_D(self):
        self.write_lines([
            "@SP",
            "M=M-1",
            "A=M",
            "D=M",
        ])

    def _binary_op(self, comp: str):
        self.write_lines([
            "@SP",
            "M=M-1",
            "A=M",
            "D=M",
            "@SP",
            "M=M-1",
            "A=M",
        ])
        if comp == "ADD":
            self.write_line("D=M+D")
        elif comp == "SUB":
            self.write_line("D=M-D")
        elif comp == "AND":
            self.write_line("D=M&D")
        elif comp == "OR":
            self.write_line("D=M|D")
        self.write_lines([
            "@SP",
            "A=M",
            "M=D",
            "@SP",
            "M=M+1",
        ])

    def _unary_op(self, comp: str):
        self.write_lines([
            "@SP",
            "A=M-1",
        ])
        if comp == "NEG":
            self.write_line("M=-M")
        elif comp == "NOT":
            self.write_line("M=!M")

    def _compare_op(self, jmp: str):
        true_label = f"TRUE_{self.label_id}"
        end_label = f"END_{self.label_id}"
        self.label_id += 1

        self.write_lines([
            "@SP",
            "M=M-1",
            "A=M",
            "D=M",
            "@SP",
            "M=M-1",
            "A=M",
            "D=M-D",
            f"@{true_label}",
            f"D;{jmp}",
            "D=0",
            f"@{end_label}",
            "0;JMP",
            f"({true_label})",
            "D=-1",
            f"({end_label})",
        ])
        self._push_D()

    def _seg_base_symbol(self, segment: str) -> str:
        if segment == "local":
            return "LCL"
        if segment == "argument":
            return "ARG"
        if segment == "this":
            return "THIS"
        if segment == "that":
            return "THAT"
        return ""

    def _push_from_segment_index(self, base_sym: str, index: int):
        self.write_lines([
            f"@{index}",
            "D=A",
            f"@{base_sym}",
            "A=M",
            "A=A+D",
            "D=M",
        ])
        self._push_D()

    def _pop_to_segment_index(self, base_sym: str, index: int):
        self.write_lines([
            f"@{index}",
            "D=A",
            f"@{base_sym}",
            "A=M",
            "D=A+D",
            "@R13",
            "M=D",
        ])
        self._pop_to_D()
        self.write_lines([
            "@R13",
            "A=M",
            "M=D",
        ])

    def write_arithmetic(self, command: str):
        if command == "add":
            self._binary_op("ADD")
        elif command == "sub":
            self._binary_op("SUB")
        elif command == "and":
            self._binary_op("AND")
        elif command == "or":
            self._binary_op("OR")
        elif command == "neg":
            self._unary_op("NEG")
        elif command == "not":
            self._unary_op("NOT")
        elif command == "eq":
            self._compare_op("JEQ")
        elif command == "gt":
            self._compare_op("JGT")
        elif command == "lt":
            self._compare_op("JLT")

    def write_push_pop(self, ctype: str, segment: str, index: int):
        if ctype == "C_PUSH":
            if segment == "constant":
                self.write_lines([
                    f"@{index}",
                    "D=A",
                ])
                self._push_D()
                return

            if segment in ("local", "argument", "this", "that"):
                base = self._seg_base_symbol(segment)
                self._push_from_segment_index(base, index)
                return

            if segment == "temp":
                addr = 5 + index
                self.write_lines([
                    f"@{addr}",
                    "D=M",
                ])
                self._push_D()
                return

            if segment == "pointer":
                if index == 0:
                    sym = "THIS"
                else:
                    sym = "THAT"
                self.write_lines([
                    f"@{sym}",
                    "D=M",
                ])
                self._push_D()
                return

            if segment == "static":
                sym = f"{self.file_name}.{index}"
                self.write_lines([
                    f"@{sym}",
                    "D=M",
                ])
                self._push_D()
                return

        elif ctype == "C_POP":
            if segment in ("local", "argument", "this", "that"):
                base = self._seg_base_symbol(segment)
                self._pop_to_segment_index(base, index)
                return

            if segment == "temp":
                addr = 5 + index
                self._pop_to_D()
                self.write_lines([
                    f"@{addr}",
                    "M=D",
                ])
                return

            if segment == "pointer":
                self._pop_to_D()
                if index == 0:
                    sym = "THIS"
                else:
                    sym = "THAT"
                self.write_lines([
                    f"@{sym}",
                    "M=D",
                ])
                return

            if segment == "static":
                sym = f"{self.file_name}.{index}"
                self._pop_to_D()
                self.write_lines([
                    f"@{sym}",
                    "M=D",
                ])
                return


def translate_file(vm_path: str, asm_path: str):
    parser = Parser(vm_path)
    cw = CodeWriter(asm_path)
    cw.set_file_name(vm_path)

    while parser.has_more_commands():
        parser.advance()
        ctype = parser.command_type()
        if ctype == "C_ARITHMETIC":
            cw.write_arithmetic(parser.arg1())
        else:
            cw.write_push_pop(ctype, parser.arg1(), parser.arg2())

    cw.close()


def main():
    if len(sys.argv) != 2:
        sys.exit(1)

    in_path = sys.argv[1]

    if not in_path.lower().endswith(".vm"):
        sys.exit(1)

    if not os.path.isfile(in_path):
        sys.exit(1)

    out_path = os.path.splitext(in_path)[0] + ".asm"
    translate_file(in_path, out_path)


if __name__ == "__main__":
    main()