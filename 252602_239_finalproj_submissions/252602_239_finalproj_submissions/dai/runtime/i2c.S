; i2c.S: polled TWI, write-only, 400 kHz, just enough for SSD1306.
; SDA=PC4, SCL=PC5 (hardwired TWI pins).
; all entry points clobber r16. byte arg to i2c_write is in r16.
; doesnt touch Y or frame pointer pairs, so safe from ISRs.

#include <avr/io.h>

.text

; TWBR=12, prescaler=1 -> SCL = 16MHz/(16+2*12) = 400 kHz.
.global i2c_init
i2c_init:
  ldi r16, 0
  sts TWSR, r16
  ldi r16, 12
  sts TWBR, r16
  ldi r16, (1 << TWEN)
  sts TWCR, r16
  ret

; send START, poll TWINT. doesnt check TWSR -- bus broken = hang here.
.global i2c_start
i2c_start:
  ldi r16, (1 << TWINT) | (1 << TWSTA) | (1 << TWEN)
  sts TWCR, r16
i2c_start_wait:
  lds r16, TWCR
  sbrs r16, TWINT
  rjmp i2c_start_wait
  ret

; r16 = byte to send. blocks until TWINT set again.
.global i2c_write
i2c_write:
  sts TWDR, r16
  ldi r16, (1 << TWINT) | (1 << TWEN)
  sts TWCR, r16
i2c_write_wait:
  lds r16, TWCR
  sbrs r16, TWINT
  rjmp i2c_write_wait
  ret

; STOP doesnt set TWINT, no wait loop.
.global i2c_stop
i2c_stop:
  ldi r16, (1 << TWINT) | (1 << TWSTO) | (1 << TWEN)
  sts TWCR, r16
  ret
