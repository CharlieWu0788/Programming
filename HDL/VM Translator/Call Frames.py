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
        cmd = parts[0]

        if cmd == "push":
            return "C_PUSH"
        if cmd == "pop":
            return "C_POP"
        if cmd == "label":
            return "C_LABEL"
        if cmd == "goto":
            return "C_GOTO"
        if cmd == "if-goto":
            return "C_IF"
        if cmd == "function":
            return "C_FUNCTION"
        if cmd == "call":
            return "C_CALL"
        if cmd == "return":
            return "C_RETURN"
        return "C_ARITHMETIC"

    def arg1(self) -> str:
        ctype = self.command_type()
        parts = self.current.split()
        if ctype == "C_ARITHMETIC":
            return parts[0]
        if ctype == "C_RETURN":
            raise ValueError("C_RETURN has no arg1")
        return parts[1]

    def arg2(self) -> int:
        parts = self.current.split()
        return int(parts[2])


class CodeWriter:
    def __init__(self, asm_path: str, write_bootstrap: bool):
        self.out = open(asm_path, "w", encoding="utf-8")
        self.file_name = ""
        self.label_id = 0
        self.call_id = 0
        self.current_function = ""

        if write_bootstrap:
            self.write_init()

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
            "AM=M-1",
            "D=M",
        ])

    def _binary_op(self, comp: str):
        self.write_lines([
            "@SP",
            "AM=M-1",
            "D=M",
            "@SP",
            "AM=M-1",
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
            "AM=M-1",
            "D=M",
            "@SP",
            "AM=M-1",
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
            "D=M+D",
            "@R13",
            "M=D",
        ])
        self._pop_to_D()
        self.write_lines([
            "@R13",
            "A=M",
            "M=D",
        ])

    def _scoped(self, label: str) -> str:
        if self.current_function:
            return f"{self.current_function}${label}"
        return label

    def _push_symbol_value(self, sym: str):
        self.write_lines([f"@{sym}", "D=M"])
        self._push_D()

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
                sym = "THIS" if index == 0 else "THAT"
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
                sym = "THIS" if index == 0 else "THAT"
                self._pop_to_D()
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

    def write_label(self, label: str):
        self.write_line(f"({self._scoped(label)})")

    def write_goto(self, label: str):
        self.write_lines([
            f"@{self._scoped(label)}",
            "0;JMP",
        ])

    def write_if(self, label: str):
        self.write_lines([
            "@SP",
            "AM=M-1",
            "D=M",
            f"@{self._scoped(label)}",
            "D;JNE",
        ])

    def write_function(self, name: str, nlocals: int):
        self.current_function = name
        self.write_line(f"({name})")
        for _ in range(nlocals):
            self.write_lines(["@0", "D=A"])
            self._push_D()

    def write_call(self, name: str, nargs: int):
        ret = f"RET_{self.call_id}"
        self.call_id += 1

        self.write_lines([
            f"@{ret}",
            "D=A",
        ])
        self._push_D()

        self._push_symbol_value("LCL")
        self._push_symbol_value("ARG")
        self._push_symbol_value("THIS")
        self._push_symbol_value("THAT")

        self.write_lines([
            "@SP",
            "D=M",
            f"@{nargs}",
            "D=D-A",
            "@5",
            "D=D-A",
            "@ARG",
            "M=D",
        ])

        self.write_lines([
            "@SP",
            "D=M",
            "@LCL",
            "M=D",
        ])

        self.write_lines([
            f"@{name}",
            "0;JMP",
            f"({ret})",
        ])

    def write_return(self):

        self.write_lines([
            "@LCL",
            "D=M",
            "@R13",
            "M=D",
        ])

        self.write_lines([
            "@R13",
            "D=M",
            "@5",
            "A=D-A",
            "D=M",
            "@R14",
            "M=D",
        ])

        self.write_lines([
            "@SP",
            "AM=M-1",
            "D=M",
            "@ARG",
            "A=M",
            "M=D",
        ])

        self.write_lines([
            "@ARG",
            "D=M+1",
            "@SP",
            "M=D",
        ])

        self.write_lines([
            "@R13",
            "AM=M-1",
            "D=M",
            "@THAT",
            "M=D",
        ])

        self.write_lines([
            "@R13",
            "AM=M-1",
            "D=M",
            "@THIS",
            "M=D",
        ])

        self.write_lines([
            "@R13",
            "AM=M-1",
            "D=M",
            "@ARG",
            "M=D",
        ])

        self.write_lines([
            "@R13",
            "AM=M-1",
            "D=M",
            "@LCL",
            "M=D",
        ])

        self.write_lines([
            "@R14",
            "A=M",
            "0;JMP",
        ])

        def write_init(self):
            self.write_lines([
                "@256",
                "D=A",
                "@SP",
                "M=D",
            ])
            self.write_call("Sys.init", 0)


def _collect_vm_files(path: str):
    files = []
    for name in os.listdir(path):
        if name.lower().endswith(".vm"):
            files.append(os.path.join(path, name))
    files.sort()
    return files


def translate(vm_inputs, asm_path: str, write_bootstrap: bool):
    cw = CodeWriter(asm_path, write_bootstrap)

    for vm_path in vm_inputs:
        cw.set_file_name(vm_path)
        parser = Parser(vm_path)
        while parser.has_more_commands():
            parser.advance()
            ctype = parser.command_type()

            if ctype == "C_ARITHMETIC":
                cw.write_arithmetic(parser.arg1())
            elif ctype in ("C_PUSH", "C_POP"):
                cw.write_push_pop(ctype, parser.arg1(), parser.arg2())
            elif ctype == "C_LABEL":
                cw.write_label(parser.arg1())
            elif ctype == "C_GOTO":
                cw.write_goto(parser.arg1())
            elif ctype == "C_IF":
                cw.write_if(parser.arg1())
            elif ctype == "C_FUNCTION":
                cw.write_function(parser.arg1(), parser.arg2())
            elif ctype == "C_CALL":
                cw.write_call(parser.arg1(), parser.arg2())
            elif ctype == "C_RETURN":
                cw.write_return()

    cw.close()


def main():
    if len(sys.argv) != 2:
        sys.exit(1)

    in_path = sys.argv[1]

    if os.path.isdir(in_path):
        vm_files = _collect_vm_files(in_path)
        if not vm_files:
            sys.exit(1)
        out_path = os.path.join(in_path, os.path.basename(os.path.normpath(in_path)) + ".asm")
        write_bootstrap = len(vm_files) > 1
        translate(vm_files, out_path, write_bootstrap)
        return

    if os.path.isfile(in_path) and in_path.lower().endswith(".vm"):
        out_path = os.path.splitext(in_path)[0] + ".asm"
        translate([in_path], out_path, write_bootstrap=False)
        return

    sys.exit(1)


if __name__ == "__main__":
    main()