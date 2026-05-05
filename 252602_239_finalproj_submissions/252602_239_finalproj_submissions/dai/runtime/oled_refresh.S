; Timer1 COMPA ISR (~32ms): pushes framebuffer over I2C.
; saves everything ssd1306_refresh/i2c clobber: r16/r17/r19/r26/r27/r30/r31 + SREG.

#include <avr/io.h>

.text
.global _timer1_compa
_timer1_compa:
  push r16
  in r16, _SFR_IO_ADDR(SREG)
  push r16
  push r17
  push r19
  push r26
  push r27
  push r30
  push r31

  rcall ssd1306_refresh

  pop r31
  pop r30
  pop r27
  pop r26
  pop r19
  pop r17
  pop r16
  out _SFR_IO_ADDR(SREG), r16
  pop r16
  reti
