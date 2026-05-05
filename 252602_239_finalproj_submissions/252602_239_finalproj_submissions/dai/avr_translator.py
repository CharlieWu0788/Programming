import sys
import os


class Parser:

    def __init__(self, filename):
        f = open(filename, 'r')
        raw = f.readlines()
        f.close()
        # strip comments and blank lines, same as before
        self._lines = []
        for line in raw:
            line = line.split('//')[0].strip()
            if line:
                self._lines.append(line)
        self._index = -1
        self._command = None

    def hasMoreLines(self):
        return self._index < len(self._lines) - 1

    def advance(self):
        self._index += 1
        self._command = self._lines[self._index]

    def commandType(self):
        word = self._command.split()[0]
        if word == 'push':
            return 'C_PUSH'
        elif word == 'pop':
            return 'C_POP'
        elif word == 'function':
            return 'C_FUNCTION'
        elif word == 'return':
            return 'C_RETURN'
        # wasnt planning to implement these for P9
        # but jack compiler emits them for if/while so had to add them
        elif word == 'label':
            return 'C_LABEL'
        elif word == 'goto':
            return 'C_GOTO'
        elif word == 'if-goto':
            return 'C_IF'
        elif word == 'call':
            return 'C_CALL'
        else:
            return 'C_ARITHMETIC'

    def arg1(self):
        if self.commandType() == 'C_ARITHMETIC':
            return self._command.split()[0]
        return self._command.split()[1]

    def arg2(self):
        return int(self._command.split()[2])


class AVRCodeWriter:

    def __init__(self, filepath, has_sys_init=False):
        self._f = open(filepath, 'w')
        self._vmname = ''
        # unique labels for comparisons, same idea as P7
        self._cmp = 0
        # static vars get fixed SRAM addresses starting at 0x0200
        # 2 bytes each for the 16-bit value
        self._statics = {}
        self._staticcount = 0
        # temp segment at 0x0210, 8 slots same as hack
        self._tempbase = 0x0210
        self._localbase_set = False
        # which function we're in, for scoping labels
        self._func = ''
        # unique labels for MMIO range-check sites
        self._mmio = 0
        # if Sys.init is in the .vm, main: rcalls Sys_init instead of falling into Main_main. Main.main's return then becomes a real return.
        self._has_sys_init = has_sys_init
        self.writeHeader()

    def setFileName(self, name):
        self._vmname = name

    # write one line to output .S file
    def w(self, line):
        if ';' in line:
            code = line.split(';', 1)[0].rstrip()
            if code:
                self._f.write(code + '\n')
        else:
            self._f.write(line + '\n')

    # header sets up the AVR chip
    # avr/io.h gives us _SFR_IO_ADDR and port names
    def writeHeader(self):
        self.w('#include <avr/io.h>')
        self.w('')
        self.w('.global main')
        self.w('main:')
        self.w('  ldi r16, lo8(RAMEND)')
        self.w('  out _SFR_IO_ADDR(SPL), r16')
        self.w('  ldi r16, hi8(RAMEND)')
        self.w('  out _SFR_IO_ADDR(SPH), r16')
        # Y = 0x0100, our VM stack starts here in SRAM
        self.w('  ldi r28, lo8(0x0100)  ; Y low = stack bottom')
        self.w('  ldi r29, hi8(0x0100)  ; Y high')
        self.w('  eor r4, r4  ; LCL = 0')
        self.w('  eor r5, r5')
        self.w('  eor r6, r6  ; ARG = 0')
        self.w('  eor r7, r7')
        self.w('  eor r8, r8  ; THIS = 0')
        self.w('  eor r9, r9')
        self.w('  eor r10, r10  ; THAT = 0')
        self.w('  eor r11, r11')
        self.w('  ldi r16, 0x0E')
        self.w('  out _SFR_IO_ADDR(DDRB), r16')
        self.w('  ldi r16, 0x01')
        self.w('  out _SFR_IO_ADDR(DDRC), r16')
        if self._has_sys_init:
            self.w('  call Sys_init  ; bootstrap (absolute, range-safe)')
            self.w('halt:')
            self.w('  rjmp halt')

    def pushR16R18(self):
        self.w('  st Y+, r16  ; push low byte')
        self.w('  st Y+, r18  ; push high byte')

    # pop top of stack into r16(low):r18(high)
    # high byte first since stack grows up
    def popR16R18(self):
        self.w('  ld r18, -Y  ; pop high byte')
        self.w('  ld r16, -Y  ; pop low byte')

    # pop into second operand pair r17:r19
    # need separate registers when doing binary ops with two values
    def popR17R19(self):
        self.w('  ld r19, -Y  ; pop high byte')
        self.w('  ld r17, -Y  ; pop low byte')

    def writeArithmetic(self, cmd):
        self.w('  ; ' + cmd)
        if cmd == 'add':
            # pop two values, add, push
            self.popR16R18()  # y
            self.popR17R19()  # x
            self.w('  add r16, r17  ; low = y_lo + x_lo')
            self.w('  adc r18, r19  ; high = y_hi + x_hi + carry')
            self.pushR16R18()
        elif cmd == 'sub':
            self.popR16R18()  
            self.popR17R19()  
            self.w('  sub r17, r16  ; x_lo - y_lo')
            self.w('  sbc r19, r18  ; x_hi - y_hi - borrow')
            # result is in r17:r19
            self.w('  st Y+, r17')
            self.w('  st Y+, r19')
        elif cmd == 'and':
            self.popR16R18() 
            self.popR17R19()  
            self.w('  and r16, r17')
            self.w('  and r18, r19')
            self.pushR16R18()
        elif cmd == 'or':
            self.popR16R18() 
            self.popR17R19()  
            self.w('  or r16, r17')
            self.w('  or r18, r19')
            self.pushR16R18()
        elif cmd == 'neg':
            self.popR16R18()
            self.w('  com r16  ; flip all bits low')
            self.w('  com r18  ; flip all bits high')
            self.w('  subi r16, 0xFF  ; add 1 to low byte (subi -1)')
            self.w('  sbci r18, 0xFF  ; propagate carry to high')
            self.pushR16R18()
        elif cmd == 'not':
            # bitwise not, com does exactly this
            self.popR16R18()
            self.w('  com r16  ; flip low')
            self.w('  com r18  ; flip high')
            self.pushR16R18()
        elif cmd == 'eq':
            self.writeCompare('breq')
        elif cmd == 'gt':
            # need positive AND nonzero, cant do it with one branch
            self.writeCompare('SIGNED_GT')
        elif cmd == 'lt':
            # signed less than: check if sign bit is set after x-y
            self.writeCompare('brlt')

    def writeCompare(self, condition):
        t = 'CMP_TRUE_' + str(self._cmp)
        e = 'CMP_END_' + str(self._cmp)
        self._cmp += 1
        # pop y then x, same order as P7
        self.popR16R18()  # y in r16:r18
        self.popR17R19()  # x in r17:r19
        # compute x - y
        self.w('  sub r17, r16  ; x_lo - y_lo')
        self.w('  sbc r19, r18  ; x_hi - y_hi - borrow')
        if condition == 'breq':
            # equal: x - y = 0, both bytes must be zero
            # OR them together, if result is 0 they were both 0
            self.w('  or r17, r19')
            self.w('  brne .+2')
            self.w('  rjmp ' + t)
        elif condition == 'brlt':
            self.w('  sbrc r19, 7  ; skip next if bit 7 clear (positive)')
            self.w('  rjmp ' + t + '  ; bit 7 set = negative = x < y')
        elif condition == 'SIGNED_GT':
            # greater than needs two checks: not negative AND not zero
            f = 'CMP_FALSE_' + str(self._cmp - 1)
            # if negative then not greater
            self.w('  sbrc r19, 7  ; skip if positive')
            self.w('  rjmp ' + f + '  ; negative = not greater')
            # if zero then also not greater
            self.w('  mov r16, r17')
            self.w('  or r16, r19')
            self.w('  brne .+2')
            self.w('  rjmp ' + f + '  ; zero = not greater')
            # passed both checks
            self.w('  rjmp ' + t)
            # false: push 0x0000
            self.w(f + ':')
            self.w('  ldi r16, 0x00')
            self.w('  ldi r18, 0x00')
            self.pushR16R18()
            self.w('  rjmp ' + e)
            # true: push 0xFFFF = -1
            self.w(t + ':')
            self.w('  ldi r16, 0xFF')
            self.w('  ldi r18, 0xFF')
            self.pushR16R18()
            self.w(e + ':')
            return
        # false: push 0x0000
        self.w('  ldi r16, 0x00')
        self.w('  ldi r18, 0x00')
        self.pushR16R18()
        self.w('  rjmp ' + e)
        # true: push 0xFFFF = -1
        self.w(t + ':')
        self.w('  ldi r16, 0xFF')
        self.w('  ldi r18, 0xFF')
        self.pushR16R18()
        self.w(e + ':')

    # push/pop

    def writePushPop(self, cmdtype, seg, i):
        if cmdtype == 'C_PUSH':
            self.writePush(seg, i)
        else:
            self.writePop(seg, i)

    def writePush(self, seg, i):
        self.w('  ; push ' + seg + ' ' + str(i))
        if seg == 'constant':
            # load value directly, like hack's @7 D=A
            # lo8/hi8 are avr-gcc macros that split 16 bits into bytes
            self.w('  ldi r16, lo8(' + str(i) + ')')
            self.w('  ldi r18, hi8(' + str(i) + ')')
            self.pushR16R18()
        elif seg == 'static':
            # same idea as P7 where each file gets its own namespace
            # but instead of @Filename.0 we use real SRAM addresses
            addr = self._getStaticAddr(i)
            self.w('  lds r16, ' + str(addr))
            self.w('  lds r18, ' + str(addr + 1))
            self.pushR16R18()
        elif seg == 'temp':
            # fixed SRAM addresses, like hack's RAM[5-12]
            addr = self._tempbase + i * 2
            self.w('  lds r16, ' + str(addr))
            self.w('  lds r18, ' + str(addr + 1))
            self.pushR16R18()
        elif seg == 'local':
            # local base is in r4:r5, copy to X then offset and load
            # X (r26:r27) supports adiw for adding small immediates
            self.w('  movw r26, r4  ; X = local base')
            if i > 0:
                self.w('  adiw r26, ' + str(i * 2))
            self.w('  ld r16, X+')
            self.w('  ld r18, X')
            self.pushR16R18()
        elif seg == 'argument':
            # same idea as local but base is r6:r7 (ARG)
            self.w('  movw r26, r6  ; X = arg base')
            if i > 0:
                self.w('  adiw r26, ' + str(i * 2))
            self.w('  ld r16, X+')
            self.w('  ld r18, X')
            self.pushR16R18()
        elif seg == 'this':
            self.w('  movw r26, r8  ; X = THIS')
            if i > 0:
                self.w('  adiw r26, ' + str(i * 2))
            self._emitMmioLoadViaX()
            self.pushR16R18()
        elif seg == 'that':
            self.w('  movw r26, r10  ; X = THAT')
            if i > 0:
                self.w('  adiw r26, ' + str(i * 2))
            self._emitMmioLoadViaX()
            self.pushR16R18()
        elif seg == 'pointer':
            # pointer 0 = THIS pointer value itself, pointer 1 = THAT value
            # we push the register contents, NOT memory[THIS]
            if i == 0:
                self.w('  mov r16, r8  ; push THIS itself')
                self.w('  mov r18, r9')
            else:
                self.w('  mov r16, r10  ; push THAT itself')
                self.w('  mov r18, r11')
            self.pushR16R18()

    def writePop(self, seg, i):
        self.w('  ; pop ' + seg + ' ' + str(i))
        if seg == 'static':
            addr = self._getStaticAddr(i)
            self.popR16R18()
            self.w('  sts ' + str(addr) + ', r16')
            self.w('  sts ' + str(addr + 1) + ', r18')
        elif seg == 'temp':
            addr = self._tempbase + i * 2
            self.popR16R18()
            self.w('  sts ' + str(addr) + ', r16')
            self.w('  sts ' + str(addr + 1) + ', r18')
        elif seg == 'local':
            # no R13 trick needed like P7 because we pop into registers
            # first then write to memory, no clobbering
            self.popR16R18()
            self.w('  movw r26, r4  ; X = local base')
            if i > 0:
                self.w('  adiw r26, ' + str(i * 2))
            self.w('  st X+, r16')
            self.w('  st X, r18')
        elif seg == 'argument':
            self.popR16R18()
            self.w('  movw r26, r6  ; X = arg base')
            if i > 0:
                self.w('  adiw r26, ' + str(i * 2))
            self.w('  st X+, r16')
            self.w('  st X, r18')
        elif seg == 'this':
            self.popR16R18()
            self.w('  movw r26, r8  ; X = THIS')
            if i > 0:
                self.w('  adiw r26, ' + str(i * 2))
            self._emitMmioStoreViaX()
        elif seg == 'that':
            self.popR16R18()
            self.w('  movw r26, r10  ; X = THAT')
            if i > 0:
                self.w('  adiw r26, ' + str(i * 2))
            self._emitMmioStoreViaX()
        elif seg == 'pointer':
            # pop into THIS or THAT register pair directly
            self.popR16R18()
            if i == 0:
                self.w('  mov r8, r16  ; THIS = popped')
                self.w('  mov r9, r18')
            else:
                self.w('  mov r10, r16  ; THAT = popped')
                self.w('  mov r11, r18')

    # maps static index to SRAM address
    # 2 bytes each starting at 0x0200
    def _getStaticAddr(self, i):
        key = self._vmname + '.' + str(i)
        if key not in self._statics:
            self._statics[key] = 0x0200 + self._staticcount * 2
            self._staticcount += 1
        return self._statics[key]

    def _emitMmioStoreViaX(self):
        n = self._mmio
        self._mmio += 1
        hi = '_MMIO_HI_' + str(n)
        end = '_MMIO_END_' + str(n)
        self.w('  cpi r27, 0x40  ; MMIO check')
        self.w('  brsh ' + hi)
        self.w('  st X+, r16  ; normal SRAM store')
        self.w('  st X, r18')
        self.w('  rjmp ' + end)
        self.w(hi + ':')
        self.w('  cpi r27, 0x60')
        self.w('  brsh ' + end + '  ; kbd range, drop writes')
        self.w('  andi r27, 0x03  ; mask to low 10 bits')
        self.w('  ori r27, 0x04  ; + 0x0400 screen base')
        self.w('  st X, r16  ; low byte only')
        self.w(end + ':')

    # load from X into r16:r18, with MMIO redirect
    def _emitMmioLoadViaX(self):
        n = self._mmio
        self._mmio += 1
        hi = '_MMIO_HI_' + str(n)
        kbd = '_MMIO_KBD_' + str(n)
        end = '_MMIO_END_' + str(n)
        self.w('  cpi r27, 0x40  ; MMIO check')
        self.w('  brsh ' + hi)
        self.w('  ld r16, X+  ; normal SRAM load')
        self.w('  ld r18, X')
        self.w('  rjmp ' + end)
        self.w(hi + ':')
        self.w('  cpi r27, 0x60')
        self.w('  brsh ' + kbd)
        self.w('  andi r27, 0x03  ; screen: low 10 bits')
        self.w('  ori r27, 0x04')
        self.w('  ld r16, X')
        self.w('  ldi r18, 0')
        self.w('  rjmp ' + end)
        self.w(kbd + ':')
        self.w('  lds r16, 0x0800  ; kbd byte')
        self.w('  ldi r18, 0')
        self.w(end + ':')

    def writeLabel(self, label):
        self.w(self._func + '_' + label + ':')

    def writeGoto(self, label):
        self.w('  rjmp ' + self._func + '_' + label)

    def writeIf(self, label):
        self.popR16R18()
        self.w('  or r16, r18')
        self.w('  breq .+2')
        self.w('  rjmp ' + self._func + '_' + label)

    def writeFunction(self, name, nLocals):
        self.w('  ; function ' + name + ' ' + str(nLocals))
        self._func = name.replace('.', '_')
        self.w(name.replace('.', '_') + ':')
        self.w('  movw r4, r28  ; LCL = SP')
        # push zeros for each local variable
        # jack expects locals initialized to 0
        for _ in range(nLocals):
            self.w('  ldi r16, 0')
            self.w('  st Y+, r16')
            self.w('  st Y+, r16')

    def writeCall(self, name, nArgs):
        self.w('  ; call ' + name + ' ' + str(nArgs))
        # save LCL, ARG, THIS, THAT (8 bytes)
        self.w('  st Y+, r4  ; save LCL')
        self.w('  st Y+, r5')
        self.w('  st Y+, r6  ; save ARG')
        self.w('  st Y+, r7')
        self.w('  st Y+, r8  ; save THIS')
        self.w('  st Y+, r9')
        self.w('  st Y+, r10  ; save THAT')
        self.w('  st Y+, r11')
        # ARG = SP - 2*nArgs - 8
        # cant subi on r6/r7 (below r16), so route through r16:r17
        offset = 2 * nArgs + 8
        self.w('  mov r16, r28')
        self.w('  mov r17, r29')
        self.w('  subi r16, lo8(' + str(offset) + ')')
        self.w('  sbci r17, hi8(' + str(offset) + ')')
        self.w('  mov r6, r16  ; ARG low')
        self.w('  mov r7, r17  ; ARG high')
        self.w('  call ' + name.replace('.', '_'))

    def writeLEDOutput(self):
        self.w('  mov r17, r16  ; copy result')
        self.w('  andi r16, 0x0E  ; bits 3-1 for PORTB')
        self.w('  out _SFR_IO_ADDR(PORTB), r16')
        self.w('  andi r17, 0x01  ; bit 0 for PORTC')
        self.w('  out _SFR_IO_ADDR(PORTC), r17')

    def writeReturn(self):
        self.w('  ; return')
        if self._func == 'Main_main' and not self._has_sys_init:
            # throw away the compiler's push constant 0
            self.popR16R18()
            # read local 0 which has the actual answer
            self.w('  movw r26, r4  ; X = local base')
            self.w('  ld r16, X+  ; load local 0 low byte')
            self.w('  ld r18, X  ; load local 0 high byte')
            self.w('  sts 0x0400, r16  ; mirror to screen byte 0')
            self.writeLEDOutput()
            self.w('halt:')
            self.w('  rjmp halt')
            return
        self.popR16R18()
        self.w('  movw r26, r4  ; X = LCL')
        self.w('  sbiw r26, 8')
        self.w('  ld r20, X+  ; r20:r21 = saved LCL (before possible clobber)')
        self.w('  ld r21, X')
        # *ARG = retval via Z
        self.w('  mov r30, r6  ; Z = ARG')
        self.w('  mov r31, r7')
        self.w('  st Z+, r16')
        self.w('  st Z, r18')
        # SP = ARG + 2
        self.w('  movw r28, r6  ; Y = ARG')
        self.w('  adiw r28, 2  ; Y = ARG + 1 word')
        # restore THAT = mem[LCL - 2] (well outside the *ARG write range)
        self.w('  movw r26, r4')
        self.w('  sbiw r26, 2')
        self.w('  ld r10, X+')
        self.w('  ld r11, X')
        # THIS = mem[LCL - 4]
        self.w('  movw r26, r4')
        self.w('  sbiw r26, 4')
        self.w('  ld r8, X+')
        self.w('  ld r9, X')
        # ARG = mem[LCL - 6]
        self.w('  movw r26, r4')
        self.w('  sbiw r26, 6')
        self.w('  ld r6, X+')
        self.w('  ld r7, X')
        # LCL from scratch r20:r21 (saved earlier)
        self.w('  mov r4, r20')
        self.w('  mov r5, r21')
        self.w('  ret')

    # for test .vm files without function/return
    # just pop result, show on LEDs, halt
    def writeEnd(self):
        self.w('  ; output and halt')
        self.popR16R18()
        self.w('  sts 0x0400, r16  ; mirror to screen byte 0')
        self.writeLEDOutput()
        self.w('halt:')
        self.w('  rjmp halt')

    def close(self):
        self._f.close()


# main

source = sys.argv[1]
dest = os.path.splitext(source)[0] + '.S'

# pre-scan: if Sys.init exists in this .vm, want main: to rcall it instead of falling through to Main.main. cheap one-pass scan, doesnt parse semantics.
has_sys_init = False
_pre = open(source, 'r')
for _line in _pre:
    if _line.split('//')[0].strip().startswith('function Sys.init'):
        has_sys_init = True
        break
_pre.close()

writer = AVRCodeWriter(dest, has_sys_init=has_sys_init)
vmname = os.path.splitext(os.path.basename(source))[0]
writer.setFileName(vmname)

parser = Parser(source)
has_return = False

# same dispatch loop as P7/P8
while parser.hasMoreLines():
    parser.advance()
    ct = parser.commandType()
    if ct == 'C_ARITHMETIC':
        writer.writeArithmetic(parser.arg1())
    elif ct == 'C_PUSH' or ct == 'C_POP':
        writer.writePushPop(ct, parser.arg1(), parser.arg2())
    elif ct == 'C_FUNCTION':
        writer.writeFunction(parser.arg1(), parser.arg2())
    elif ct == 'C_RETURN':
        has_return = True
        writer.writeReturn()
    elif ct == 'C_LABEL':
        writer.writeLabel(parser.arg1())
    elif ct == 'C_GOTO':
        writer.writeGoto(parser.arg1())
    elif ct == 'C_IF':
        writer.writeIf(parser.arg1())
    elif ct == 'C_CALL':
        writer.writeCall(parser.arg1(), parser.arg2())

if not has_return:
    writer.writeEnd()

writer.close()
