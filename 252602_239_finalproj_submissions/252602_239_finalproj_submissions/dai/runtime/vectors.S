; atmega328p vector table.
; each slot is 2 bytes -> rjmp only. but rjmp range is +/-4KB and once
; the Jack OS is linked, handlers sit past that. so each active vector
; rjmps to a trampoline in this same section that does absolute jmp.

#include <avr/io.h>

.section .vectors, "ax", @progbits
.global __vectors
__vectors:
  rjmp _reset_t
  rjmp _badisr
  rjmp _badisr
  rjmp _badisr
  rjmp _badisr
  rjmp _badisr
  rjmp _badisr
  rjmp _badisr
  rjmp _badisr
  rjmp _badisr
  rjmp _badisr
  ; 11 TIMER1_COMPA: OLED refresh
  rjmp _timer1_compa_t
  rjmp _badisr
  rjmp _badisr
  rjmp _badisr
  rjmp _badisr
  ; 16 TIMER0_OVF: LED mirror + button poll
  rjmp _timer0_ovf_t
  rjmp _badisr
  rjmp _badisr
  rjmp _badisr
  rjmp _badisr
  rjmp _badisr
  rjmp _badisr
  rjmp _badisr
  rjmp _badisr
  rjmp _badisr

; trampolines stay in .vectors so the vector-table rjmps can reach them.
_reset_t:
  jmp _reset
_timer0_ovf_t:
  jmp _timer0_ovf
_timer1_compa_t:
  jmp _timer1_compa

.global _badisr
_badisr:
  reti
