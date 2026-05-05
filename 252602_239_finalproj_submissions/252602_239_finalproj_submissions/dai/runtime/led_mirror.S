; Timer0 overflow ISR (~16ms). does two jobs:
; mirror low 4 bits of 0x0400 to LEDs.
; poll PD2-PD5, write 1..4 (or 0) to 0x0800.

#include <avr/io.h>

.text
.global _timer0_ovf
_timer0_ovf:
  push r16
  in r16, _SFR_IO_ADDR(SREG)
  push r16
  push r17
  push r18

  ; LED mirror: bits 1..3 of screen[0] -> PB1..PB3, bit 0 -> PC0
  lds r16, 0x0400
  mov r17, r16
  andi r17, 0x0E
  in r18, _SFR_IO_ADDR(PORTB)
  andi r18, 0xF1
  or r18, r17
  out _SFR_IO_ADDR(PORTB), r18
  andi r16, 0x01
  in r17, _SFR_IO_ADDR(PORTC)
  andi r17, 0xFE
  or r17, r16
  out _SFR_IO_ADDR(PORTC), r17

  ; button poll: pullups -> pressed = low. last pressed wins.
  in r16, _SFR_IO_ADDR(PIND)
  com r16
  andi r16, 0x3C
  ldi r17, 0
  sbrc r16, 2
  ldi r17, 1
  sbrc r16, 3
  ldi r17, 2
  sbrc r16, 4
  ldi r17, 3
  sbrc r16, 5
  ldi r17, 4
  sts 0x0800, r17

  pop r18
  pop r17
  pop r16
  out _SFR_IO_ADDR(SREG), r16
  pop r16
  reti
