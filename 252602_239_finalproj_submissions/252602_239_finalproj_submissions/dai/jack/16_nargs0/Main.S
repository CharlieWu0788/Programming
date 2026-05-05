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
Main_getFive:
  movw r4, r28
  ldi r16, lo8(5)
  ldi r18, hi8(5)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  sbiw r26, 8
  ld r20, X+
  ld r21, X
  mov r30, r6
  mov r31, r7
  st Z+, r16
  st Z, r18
  movw r28, r6
  adiw r28, 2
  movw r26, r4
  sbiw r26, 2
  ld r10, X+
  ld r11, X
  movw r26, r4
  sbiw r26, 4
  ld r8, X+
  ld r9, X
  movw r26, r4
  sbiw r26, 6
  ld r6, X+
  ld r7, X
  mov r4, r20
  mov r5, r21
  ret
Main_main:
  movw r4, r28
  ldi r16, 0
  st Y+, r16
  st Y+, r16
  st Y+, r4
  st Y+, r5
  st Y+, r6
  st Y+, r7
  st Y+, r8
  st Y+, r9
  st Y+, r10
  st Y+, r11
  mov r16, r28
  mov r17, r29
  subi r16, lo8(8)
  sbci r17, hi8(8)
  mov r6, r16
  mov r7, r17
  call Main_getFive
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  st X+, r16
  st X, r18
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
