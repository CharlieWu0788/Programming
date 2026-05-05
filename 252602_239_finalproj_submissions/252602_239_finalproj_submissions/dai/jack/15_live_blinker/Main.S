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
Main_main_LOOP:
  ldi r16, lo8(16384)
  ldi r18, hi8(16384)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  mov r10, r16
  mov r11, r18
  ldi r16, lo8(1)
  ldi r18, hi8(1)
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
  st Y+, r4
  st Y+, r5
  st Y+, r6
  st Y+, r7
  st Y+, r8
  st Y+, r9
  st Y+, r10
  st Y+, r11
  mov r16, r28
  mov r17, r29
  subi r16, lo8(8)
  sbci r17, hi8(8)
  mov r6, r16
  mov r7, r17
  call Main_delay
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
  ldi r16, lo8(16384)
  ldi r18, hi8(16384)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  mov r10, r16
  mov r11, r18
  ldi r16, lo8(2)
  ldi r18, hi8(2)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r10
  cpi r27, 0x40
  brsh _MMIO_HI_1
  st X+, r16
  st X, r18
  rjmp _MMIO_END_1
_MMIO_HI_1:
  cpi r27, 0x60
  brsh _MMIO_END_1
  andi r27, 0x03
  ori r27, 0x04
  st X, r16
_MMIO_END_1:
  st Y+, r4
  st Y+, r5
  st Y+, r6
  st Y+, r7
  st Y+, r8
  st Y+, r9
  st Y+, r10
  st Y+, r11
  mov r16, r28
  mov r17, r29
  subi r16, lo8(8)
  sbci r17, hi8(8)
  mov r6, r16
  mov r7, r17
  call Main_delay
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
  ldi r16, lo8(16384)
  ldi r18, hi8(16384)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  mov r10, r16
  mov r11, r18
  ldi r16, lo8(4)
  ldi r18, hi8(4)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r10
  cpi r27, 0x40
  brsh _MMIO_HI_2
  st X+, r16
  st X, r18
  rjmp _MMIO_END_2
_MMIO_HI_2:
  cpi r27, 0x60
  brsh _MMIO_END_2
  andi r27, 0x03
  ori r27, 0x04
  st X, r16
_MMIO_END_2:
  st Y+, r4
  st Y+, r5
  st Y+, r6
  st Y+, r7
  st Y+, r8
  st Y+, r9
  st Y+, r10
  st Y+, r11
  mov r16, r28
  mov r17, r29
  subi r16, lo8(8)
  sbci r17, hi8(8)
  mov r6, r16
  mov r7, r17
  call Main_delay
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
  ldi r16, lo8(16384)
  ldi r18, hi8(16384)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  mov r10, r16
  mov r11, r18
  ldi r16, lo8(8)
  ldi r18, hi8(8)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r10
  cpi r27, 0x40
  brsh _MMIO_HI_3
  st X+, r16
  st X, r18
  rjmp _MMIO_END_3
_MMIO_HI_3:
  cpi r27, 0x60
  brsh _MMIO_END_3
  andi r27, 0x03
  ori r27, 0x04
  st X, r16
_MMIO_END_3:
  st Y+, r4
  st Y+, r5
  st Y+, r6
  st Y+, r7
  st Y+, r8
  st Y+, r9
  st Y+, r10
  st Y+, r11
  mov r16, r28
  mov r17, r29
  subi r16, lo8(8)
  sbci r17, hi8(8)
  mov r6, r16
  mov r7, r17
  call Main_delay
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
  ldi r16, lo8(16384)
  ldi r18, hi8(16384)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  mov r10, r16
  mov r11, r18
  ldi r16, lo8(15)
  ldi r18, hi8(15)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r10
  cpi r27, 0x40
  brsh _MMIO_HI_4
  st X+, r16
  st X, r18
  rjmp _MMIO_END_4
_MMIO_HI_4:
  cpi r27, 0x60
  brsh _MMIO_END_4
  andi r27, 0x03
  ori r27, 0x04
  st X, r16
_MMIO_END_4:
  st Y+, r4
  st Y+, r5
  st Y+, r6
  st Y+, r7
  st Y+, r8
  st Y+, r9
  st Y+, r10
  st Y+, r11
  mov r16, r28
  mov r17, r29
  subi r16, lo8(8)
  sbci r17, hi8(8)
  mov r6, r16
  mov r7, r17
  call Main_delay
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
  ldi r16, lo8(16384)
  ldi r18, hi8(16384)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  mov r10, r16
  mov r11, r18
  ldi r16, lo8(0)
  ldi r18, hi8(0)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r10
  cpi r27, 0x40
  brsh _MMIO_HI_5
  st X+, r16
  st X, r18
  rjmp _MMIO_END_5
_MMIO_HI_5:
  cpi r27, 0x60
  brsh _MMIO_END_5
  andi r27, 0x03
  ori r27, 0x04
  st X, r16
_MMIO_END_5:
  st Y+, r4
  st Y+, r5
  st Y+, r6
  st Y+, r7
  st Y+, r8
  st Y+, r9
  st Y+, r10
  st Y+, r11
  mov r16, r28
  mov r17, r29
  subi r16, lo8(8)
  sbci r17, hi8(8)
  mov r6, r16
  mov r7, r17
  call Main_delay
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
  rjmp Main_main_LOOP
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
Main_delay:
  movw r4, r28
  ldi r16, 0
  st Y+, r16
  st Y+, r16
  ldi r16, lo8(0)
  ldi r18, hi8(0)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  st X+, r16
  st X, r18
Main_delay_DELAY_LOOP:
  movw r26, r4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(20000)
  ldi r18, hi8(20000)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  sbrc r19, 7
  rjmp CMP_TRUE_0
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_0
CMP_TRUE_0:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_0:
  ld r18, -Y
  ld r16, -Y
  com r16
  com r18
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  or r16, r18
  breq .+2
  rjmp Main_delay_DELAY_END
  movw r26, r4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(1)
  ldi r18, hi8(1)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  add r16, r17
  adc r18, r19
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  st X+, r16
  st X, r18
  rjmp Main_delay_DELAY_LOOP
Main_delay_DELAY_END:
  ldi r16, lo8(0)
  ldi r18, hi8(0)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  sbiw r26, 8
  ld r20, X+
  ld r21, X
  mov r30, r6
  mov r31, r7
  st Z+, r16
  st Z, r18
  movw r28, r6
  adiw r28, 2
  movw r26, r4
  sbiw r26, 2
  ld r10, X+
  ld r11, X
  movw r26, r4
  sbiw r26, 4
  ld r8, X+
  ld r9, X
  movw r26, r4
  sbiw r26, 6
  ld r6, X+
  ld r7, X
  mov r4, r20
  mov r5, r21
  ret
