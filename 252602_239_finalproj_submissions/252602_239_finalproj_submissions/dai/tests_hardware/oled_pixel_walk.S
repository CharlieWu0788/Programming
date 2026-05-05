; oled_pixel_walk.S -- animated pixel on the OLED.

#include <avr/io.h>

.global main
main:
  ; clear framebuffer 0x0400..0x07FF (1024 bytes)
  ldi r26, lo8(0x0400)
  ldi r27, hi8(0x0400)
  ldi r19, 4
clr_o:
  clr r17
clr_i:
  clr r16
  st X+, r16
  dec r17
  brne clr_i
  dec r19
  brne clr_o

  ; r24 = current bar offset within first page (0..127)
  ldi r24, 0

walk_loop:
  ; clear previous bar
  ldi r26, lo8(0x0400)
  ldi r27, hi8(0x0400)
  add r26, r24
  adc r27, r1           
  ; r1 is 0 by AVR convention (zeroed in startup)
  clr r16
  st X, r16

  ; advance, wrap at 128 (first SSD1306 page)
  inc r24
  cpi r24, 128
  brlo no_wrap
  clr r24
no_wrap:

  ; write bar at new offset
  ldi r26, lo8(0x0400)
  ldi r27, hi8(0x0400)
  add r26, r24
  adc r27, r1
  ldi r16, 0xFF
  st X, r16

  ; busy-wait so movement is visible (~80ms-ish).
  ; sbiw needs r24/26/28/30 pair, so use Z = r30:r31.
  ldi r25, 30
delay_o:
  ldi r30, 0
  ldi r31, 0
delay_i:
  sbiw r30, 1
  brne delay_i
  dec r25
  brne delay_o

  rjmp walk_loop
