; buttons_live.S -- read button kbd code from runtime, mirror to LEDs.

#include <avr/io.h>

.global main
main:
loop:
  lds r16, 0x0800       
  ; convert to bit pattern: code N -> bit N-1
  ; 0 -> 0, 1 -> 1, 2 -> 2, 3 -> 4, 4 -> 8
  ldi r17, 0
  cpi r16, 0
  breq write
  cpi r16, 1
  brne not1
  ldi r17, 1
  rjmp write
not1:
  cpi r16, 2
  brne not2
  ldi r17, 2
  rjmp write
not2:
  cpi r16, 3
  brne not3
  ldi r17, 4
  rjmp write
not3:
  cpi r16, 4
  brne write
  ldi r17, 8
write:
  sts 0x0400, r17
  rjmp loop
