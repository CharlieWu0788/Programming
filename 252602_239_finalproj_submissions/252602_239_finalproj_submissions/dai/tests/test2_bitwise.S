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
  ldi r16, lo8(5)
  ldi r18, hi8(5)
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(10)
  ldi r18, hi8(10)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  or r16, r17
  or r18, r19
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  sts 0x0400, r16
  mov r17, r16
  andi r16, 0x0E
  out _SFR_IO_ADDR(PORTB), r16
  andi r17, 0x01
  out _SFR_IO_ADDR(PORTC), r17
halt:
  rjmp halt
