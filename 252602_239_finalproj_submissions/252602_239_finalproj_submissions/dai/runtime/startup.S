; _reset: bootstrap from reset vector.
; sets up hw + VM stacks, zeros frame ptrs, clears screen buffer,
; brings up DDR + pullups + Timer0 + Timer1 + OLED, then jmp main.

#include <avr/io.h>

.text
.global _reset
_reset:
  ; r1 must stay 0 per avr-gcc convention.
  clr r1
  out _SFR_IO_ADDR(SREG), r1

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

  ; zero screen buffer 0x0400..0x07FF + keyboard byte 0x0800.
  ; without this the LED mirror flashes garbage on boot.
  ldi r26, lo8(0x0400)
  ldi r27, hi8(0x0400)
  clr r16
  ldi r19, 4
_zero_outer:
  clr r17
_zero_inner:
  st X+, r16
  dec r17
  brne _zero_inner
  dec r19
  brne _zero_outer
  sts 0x0800, r16

  ; LED pins (PB1-3, PC0) output; buttons PD2-PD5 input + pullups
  ldi r16, 0x0E
  out _SFR_IO_ADDR(DDRB), r16
  ldi r16, 0x01
  out _SFR_IO_ADDR(DDRC), r16
  clr r16
  out _SFR_IO_ADDR(DDRD), r16
  ldi r16, 0x3C
  out _SFR_IO_ADDR(PORTD), r16

  ; Timer0 /1024 overflow -> 16.384 ms tick (LED mirror + button poll)
  ldi r16, 0x05
  out _SFR_IO_ADDR(TCCR0B), r16
  ldi r16, 0x01
  sts TIMSK0, r16

  ; ~65ms delay so SSD1306 settles after VCC, otherwise first cmd gets dropped
  ldi r25, 4
_oled_delay_o:
  ldi r26, 0
  ldi r27, 0xFF
_oled_delay_i:
  sbiw r26, 1
  brne _oled_delay_i
  dec r25
  brne _oled_delay_o
  rcall ssd1306_init

  ; Timer1 CTC /256, OCR1A=2000 -> 32 ms (~30 Hz OLED refresh)
  ldi r16, 0
  sts TCCR1A, r16
  ldi r16, (1 << WGM12) | (1 << CS12)
  sts TCCR1B, r16
  ; high byte FIRST per datasheet (16-bit register access)
  ldi r16, hi8(2000)
  sts OCR1AH, r16
  ldi r16, lo8(2000)
  sts OCR1AL, r16
  ldi r16, (1 << OCIE1A)
  sts TIMSK1, r16

  sei

  ; jmp not rjmp: main: is past rjmp's +/- 4KB once Jack OS is linked.
  jmp main
