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
  ldi r16, lo8(16384)
  ldi r18, hi8(16384)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  mov r10, r16
  mov r11, r18
  ldi r16, lo8(5)
  ldi r18, hi8(5)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r10
  cpi r27, 0x40
  brsh _MMIO_HI_0
  st X+, r16
  st X, r18
  rjmp _MMIO_END_0
_MMIO_HI_0:
  cpi r27, 0x60
  brsh _MMIO_END_0
  andi r27, 0x03
  ori r27, 0x04
  st X, r16
_MMIO_END_0:
  movw r26, r10
  cpi r27, 0x40
  brsh _MMIO_HI_1
  ld r16, X+
  ld r18, X
  rjmp _MMIO_END_1
_MMIO_HI_1:
  cpi r27, 0x60
  brsh _MMIO_KBD_1
  andi r27, 0x03
  ori r27, 0x04
  ld r16, X
  ldi r18, 0
  rjmp _MMIO_END_1
_MMIO_KBD_1:
  lds r16, 0x0800
  ldi r18, 0
_MMIO_END_1:
  st Y+, r16
  st Y+, r18
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
