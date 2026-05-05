#include <avr/io.h>

.global main
main:
  ldi r16, lo8(RAMEND)
  out _SFR_IO_ADDR(SPL), r16
  ldi r16, hi8(RAMEND)
  out _SFR_IO_ADDR(SPH), r16
  ldi r28, lo8(0x0100)
  ldi r29, hi8(0x0100)
  eor r4, r4
  eor r5, r5
  eor r6, r6
  eor r7, r7
  eor r8, r8
  eor r9, r9
  eor r10, r10
  eor r11, r11
  ldi r16, 0x0E
  out _SFR_IO_ADDR(DDRB), r16
  ldi r16, 0x01
  out _SFR_IO_ADDR(DDRC), r16
Main_main:
  movw r4, r28
  ldi r16, 0
  st Y+, r16
  st Y+, r16
  ldi r16, 0
  st Y+, r16
  st Y+, r16
  ldi r16, 0
  st Y+, r16
  st Y+, r16
  ldi r16, lo8(3)
  ldi r18, hi8(3)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  st X+, r16
  st X, r18
  ldi r16, lo8(11)
  ldi r18, hi8(11)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  adiw r26, 2
  st X+, r16
  st X, r18
  ldi r16, lo8(7)
  ldi r18, hi8(7)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  adiw r26, 4
  st X+, r16
  st X, r18
  movw r26, r4
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  sbrc r19, 7
  rjmp CMP_FALSE_0
  mov r16, r17
  or r16, r19
  brne .+2
  rjmp CMP_FALSE_0
  rjmp CMP_TRUE_0
CMP_FALSE_0:
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_0
CMP_TRUE_0:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_0:
  ld r18, -Y
  ld r16, -Y
  com r16
  com r18
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  or r16, r18
  breq .+2
  rjmp Main_main_IF_FALSE0
  movw r26, r4
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  st X+, r16
  st X, r18
Main_main_IF_FALSE0:
  movw r26, r4
  adiw r26, 4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  sbrc r19, 7
  rjmp CMP_FALSE_1
  mov r16, r17
  or r16, r19
  brne .+2
  rjmp CMP_FALSE_1
  rjmp CMP_TRUE_1
CMP_FALSE_1:
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_1
CMP_TRUE_1:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_1:
  ld r18, -Y
  ld r16, -Y
  com r16
  com r18
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  or r16, r18
  breq .+2
  rjmp Main_main_IF_FALSE1
  movw r26, r4
  adiw r26, 4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  st X+, r16
  st X, r18
Main_main_IF_FALSE1:
  ldi r16, lo8(0)
  ldi r18, hi8(0)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  ld r16, X+
  ld r18, X
  sts 0x0400, r16
  mov r17, r16
  andi r16, 0x0E
  out _SFR_IO_ADDR(PORTB), r16
  andi r17, 0x01
  out _SFR_IO_ADDR(PORTC), r17
halt:
  rjmp halt
