; ssd1306.S: SSD1306 driver, 0.96" 128x64.
; init table is in flash, walked with lpm.
; framebuffer at 0x0400..0x07FF (1024 bytes), refreshed by Timer1 ISR.

#include <avr/io.h>

.text

; ssd1306_cmd: send one command byte (in r16) over I2C.
.global ssd1306_cmd
ssd1306_cmd:
  push r16
  rcall i2c_start
  ; SSD1306 write address (0x3C << 1)
  ldi r16, 0x78
  rcall i2c_write
  ; control byte: Co=0, D/C=0 -> command coming
  ldi r16, 0x00
  rcall i2c_write
  pop r16
  rcall i2c_write
  rcall i2c_stop
  ret

; ssd1306_init: run the canonical 128x64 init sequence, then enable display.
.global ssd1306_init
ssd1306_init:
  rcall i2c_init
  ldi r30, lo8(_init_seq)
  ldi r31, hi8(_init_seq)
  ldi r17, _init_seq_end - _init_seq
_init_loop:
  lpm r16, Z+
  rcall ssd1306_cmd
  dec r17
  brne _init_loop
  ret

; ssd1306_refresh: stream the 1024-byte framebuffer to GDDRAM in one I2C
; transaction. SSD1306 auto-increments its address pointer in horizontal mode.
; clobbers r16, r17, r19, r26, r27: caller (timer1 ISR) saves these.
.global ssd1306_refresh
ssd1306_refresh:
  ; column address: 0x21, start, end
  ldi r16, 0x21
  rcall ssd1306_cmd
  ldi r16, 0x00
  rcall ssd1306_cmd
  ldi r16, 0x7F
  rcall ssd1306_cmd
  ; page address: 0x22, start, end
  ldi r16, 0x22
  rcall ssd1306_cmd
  ldi r16, 0x00
  rcall ssd1306_cmd
  ldi r16, 0x07
  rcall ssd1306_cmd

  rcall i2c_start
  ldi r16, 0x78
  rcall i2c_write
  ; control: Co=0, D/C=1 -> data stream
  ldi r16, 0x40
  rcall i2c_write

  ; outer 4 * inner 256 = 1024 bytes (inner: 0 wraps to 0xFF, counts down)
  ldi r26, lo8(0x0400)
  ldi r27, hi8(0x0400)
  ldi r19, 4
_fb_outer:
  ldi r17, 0
_fb_inner:
  ld r16, X+
  rcall i2c_write
  dec r17
  brne _fb_inner
  dec r19
  brne _fb_outer

  rcall i2c_stop
  ret

; canonical SSD1306 128x64 init sequence in flash, walked with lpm.
_init_seq:
  .byte 0xAE
  .byte 0xD5, 0x80
  .byte 0xA8, 0x3F
  .byte 0xD3, 0x00
  .byte 0x40
  .byte 0x8D, 0x14
  .byte 0x20, 0x00
  .byte 0xA1
  .byte 0xC8
  .byte 0xDA, 0x12
  .byte 0x81, 0xCF
  .byte 0xD9, 0xF1
  .byte 0xDB, 0x40
  .byte 0xA4
  .byte 0xA6
  .byte 0xAF
_init_seq_end:
  ; table is 25 bytes (odd). pad so rjmp targets stay word-aligned.
  .balign 2
