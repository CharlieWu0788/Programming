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
  call Sys_init
halt:
  rjmp halt
Sys_init:
  movw r4, r28
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
  call Memory_init
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
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
  call Math_init
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
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
  call Screen_init
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
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
  call Output_init
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
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
  call Main_main
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
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
  call Sys_halt
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
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
Sys_halt:
  movw r4, r28
Sys_halt_L0:
  ldi r16, lo8(0)
  ldi r18, hi8(0)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  com r16
  com r18
  st Y+, r16
  st Y+, r18
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
  rjmp Sys_halt_L1
  rjmp Sys_halt_L0
Sys_halt_L1:
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
Sys_wait:
  movw r4, r28
  ldi r16, 0
  st Y+, r16
  st Y+, r16
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
Sys_wait_L2:
  movw r26, r4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r6
  ld r16, X+
  ld r18, X
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
  rjmp Sys_wait_L3
  ldi r16, lo8(0)
  ldi r18, hi8(0)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  adiw r26, 2
  st X+, r16
  st X, r18
Sys_wait_L4:
  movw r26, r4
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(80)
  ldi r18, hi8(80)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  sbrc r19, 7
  rjmp CMP_TRUE_1
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_1
CMP_TRUE_1:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_1:
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
  rjmp Sys_wait_L5
  movw r26, r4
  adiw r26, 2
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
  adiw r26, 2
  st X+, r16
  st X, r18
  rjmp Sys_wait_L4
Sys_wait_L5:
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
  rjmp Sys_wait_L2
Sys_wait_L3:
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
Sys_error:
  movw r4, r28
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
  call Sys_halt
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
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
Main_stepAt:
  movw r4, r28
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(0)
  ldi r18, hi8(0)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  or r17, r19
  brne .+2
  rjmp CMP_TRUE_2
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_2
CMP_TRUE_2:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_2:
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
  rjmp Main_stepAt_L0
  ldi r16, lo8(1)
  ldi r18, hi8(1)
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
Main_stepAt_L0:
  movw r26, r6
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
  sub r17, r16
  sbc r19, r18
  or r17, r19
  brne .+2
  rjmp CMP_TRUE_3
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_3
CMP_TRUE_3:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_3:
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
  rjmp Main_stepAt_L2
  ldi r16, lo8(2)
  ldi r18, hi8(2)
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
Main_stepAt_L2:
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(2)
  ldi r18, hi8(2)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  or r17, r19
  brne .+2
  rjmp CMP_TRUE_4
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_4
CMP_TRUE_4:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_4:
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
  rjmp Main_stepAt_L4
  ldi r16, lo8(4)
  ldi r18, hi8(4)
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
Main_stepAt_L4:
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(3)
  ldi r18, hi8(3)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  or r17, r19
  brne .+2
  rjmp CMP_TRUE_5
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_5
CMP_TRUE_5:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_5:
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
  rjmp Main_stepAt_L6
  ldi r16, lo8(3)
  ldi r18, hi8(3)
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
Main_stepAt_L6:
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(4)
  ldi r18, hi8(4)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  or r17, r19
  brne .+2
  rjmp CMP_TRUE_6
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_6
CMP_TRUE_6:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_6:
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
  rjmp Main_stepAt_L8
  ldi r16, lo8(1)
  ldi r18, hi8(1)
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
Main_stepAt_L8:
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(5)
  ldi r18, hi8(5)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  or r17, r19
  brne .+2
  rjmp CMP_TRUE_7
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_7
CMP_TRUE_7:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_7:
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
  rjmp Main_stepAt_L10
  ldi r16, lo8(4)
  ldi r18, hi8(4)
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
Main_stepAt_L10:
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(6)
  ldi r18, hi8(6)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  or r17, r19
  brne .+2
  rjmp CMP_TRUE_8
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_8
CMP_TRUE_8:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_8:
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
  rjmp Main_stepAt_L12
  ldi r16, lo8(2)
  ldi r18, hi8(2)
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
Main_stepAt_L12:
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(7)
  ldi r18, hi8(7)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  or r17, r19
  brne .+2
  rjmp CMP_TRUE_9
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_9
CMP_TRUE_9:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_9:
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
  rjmp Main_stepAt_L14
  ldi r16, lo8(3)
  ldi r18, hi8(3)
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
Main_stepAt_L14:
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(8)
  ldi r18, hi8(8)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  or r17, r19
  brne .+2
  rjmp CMP_TRUE_10
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_10
CMP_TRUE_10:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_10:
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
  rjmp Main_stepAt_L16
  ldi r16, lo8(4)
  ldi r18, hi8(4)
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
Main_stepAt_L16:
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(9)
  ldi r18, hi8(9)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  or r17, r19
  brne .+2
  rjmp CMP_TRUE_11
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_11
CMP_TRUE_11:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_11:
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
  rjmp Main_stepAt_L18
  ldi r16, lo8(1)
  ldi r18, hi8(1)
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
Main_stepAt_L18:
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(10)
  ldi r18, hi8(10)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  or r17, r19
  brne .+2
  rjmp CMP_TRUE_12
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_12
CMP_TRUE_12:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_12:
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
  rjmp Main_stepAt_L20
  ldi r16, lo8(3)
  ldi r18, hi8(3)
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
Main_stepAt_L20:
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(11)
  ldi r18, hi8(11)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  or r17, r19
  brne .+2
  rjmp CMP_TRUE_13
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_13
CMP_TRUE_13:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_13:
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
  rjmp Main_stepAt_L22
  ldi r16, lo8(2)
  ldi r18, hi8(2)
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
Main_stepAt_L22:
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(12)
  ldi r18, hi8(12)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  or r17, r19
  brne .+2
  rjmp CMP_TRUE_14
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_14
CMP_TRUE_14:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_14:
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
  rjmp Main_stepAt_L24
  ldi r16, lo8(4)
  ldi r18, hi8(4)
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
Main_stepAt_L24:
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(13)
  ldi r18, hi8(13)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  or r17, r19
  brne .+2
  rjmp CMP_TRUE_15
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_15
CMP_TRUE_15:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_15:
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
  rjmp Main_stepAt_L26
  ldi r16, lo8(2)
  ldi r18, hi8(2)
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
Main_stepAt_L26:
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(14)
  ldi r18, hi8(14)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  or r17, r19
  brne .+2
  rjmp CMP_TRUE_16
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_16
CMP_TRUE_16:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_16:
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
  rjmp Main_stepAt_L28
  ldi r16, lo8(1)
  ldi r18, hi8(1)
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
Main_stepAt_L28:
  ldi r16, lo8(3)
  ldi r18, hi8(3)
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
Main_flash:
  movw r4, r28
  ldi r16, 0
  st Y+, r16
  st Y+, r16
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
  ldi r16, lo8(0)
  ldi r18, hi8(0)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  adiw r26, 2
  st X+, r16
  st X, r18
  movw r26, r6
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
  sub r17, r16
  sbc r19, r18
  or r17, r19
  brne .+2
  rjmp CMP_TRUE_17
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_17
CMP_TRUE_17:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_17:
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
  rjmp Main_flash_L30
  ldi r16, lo8(1)
  ldi r18, hi8(1)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  st X+, r16
  st X, r18
  ldi r16, lo8(16512)
  ldi r18, hi8(16512)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  adiw r26, 2
  st X+, r16
  st X, r18
Main_flash_L30:
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(2)
  ldi r18, hi8(2)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  or r17, r19
  brne .+2
  rjmp CMP_TRUE_18
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_18
CMP_TRUE_18:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_18:
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
  rjmp Main_flash_L32
  ldi r16, lo8(2)
  ldi r18, hi8(2)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  st X+, r16
  st X, r18
  ldi r16, lo8(16640)
  ldi r18, hi8(16640)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  adiw r26, 2
  st X+, r16
  st X, r18
Main_flash_L32:
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(3)
  ldi r18, hi8(3)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  or r17, r19
  brne .+2
  rjmp CMP_TRUE_19
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_19
CMP_TRUE_19:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_19:
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
  rjmp Main_flash_L34
  ldi r16, lo8(4)
  ldi r18, hi8(4)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  st X+, r16
  st X, r18
  ldi r16, lo8(16768)
  ldi r18, hi8(16768)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  adiw r26, 2
  st X+, r16
  st X, r18
Main_flash_L34:
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(4)
  ldi r18, hi8(4)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  or r17, r19
  brne .+2
  rjmp CMP_TRUE_20
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_20
CMP_TRUE_20:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_20:
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
  rjmp Main_flash_L36
  ldi r16, lo8(8)
  ldi r18, hi8(8)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  st X+, r16
  st X, r18
  ldi r16, lo8(16896)
  ldi r18, hi8(16896)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  adiw r26, 2
  st X+, r16
  st X, r18
Main_flash_L36:
  ldi r16, lo8(16384)
  ldi r18, hi8(16384)
  st Y+, r16
  st Y+, r18
  movw r26, r4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
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
  subi r16, lo8(12)
  sbci r17, hi8(12)
  mov r6, r16
  mov r7, r17
  call Memory_poke
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
  movw r26, r4
  adiw r26, 2
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
  com r16
  com r18
  subi r16, 0xFF
  sbci r18, 0xFF
  st Y+, r16
  st Y+, r18
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
  subi r16, lo8(12)
  sbci r17, hi8(12)
  mov r6, r16
  mov r7, r17
  call Memory_poke
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
  ldi r16, lo8(120)
  ldi r18, hi8(120)
  st Y+, r16
  st Y+, r18
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
  subi r16, lo8(10)
  sbci r17, hi8(10)
  mov r6, r16
  mov r7, r17
  call Sys_wait
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
  ldi r16, lo8(16384)
  ldi r18, hi8(16384)
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(0)
  ldi r18, hi8(0)
  st Y+, r16
  st Y+, r18
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
  subi r16, lo8(12)
  sbci r17, hi8(12)
  mov r6, r16
  mov r7, r17
  call Memory_poke
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
  movw r26, r4
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(0)
  ldi r18, hi8(0)
  st Y+, r16
  st Y+, r18
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
  subi r16, lo8(12)
  sbci r17, hi8(12)
  mov r6, r16
  mov r7, r17
  call Memory_poke
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
  ldi r16, lo8(40)
  ldi r18, hi8(40)
  st Y+, r16
  st Y+, r18
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
  subi r16, lo8(10)
  sbci r17, hi8(10)
  mov r6, r16
  mov r7, r17
  call Sys_wait
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
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
Main_readButton:
  movw r4, r28
  ldi r16, 0
  st Y+, r16
  st Y+, r16
Main_readButton_L38:
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
  call Keyboard_keyPressed
  ldi r16, lo8(0)
  ldi r18, hi8(0)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  or r17, r19
  brne .+2
  rjmp CMP_TRUE_21
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_21
CMP_TRUE_21:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_21:
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
  rjmp Main_readButton_L39
  rjmp Main_readButton_L38
Main_readButton_L39:
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
  call Keyboard_keyPressed
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  st X+, r16
  st X, r18
Main_readButton_L40:
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
  call Keyboard_keyPressed
  ldi r16, lo8(0)
  ldi r18, hi8(0)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  or r17, r19
  brne .+2
  rjmp CMP_TRUE_22
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_22
CMP_TRUE_22:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_22:
  ld r18, -Y
  ld r16, -Y
  com r16
  com r18
  st Y+, r16
  st Y+, r18
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
  rjmp Main_readButton_L41
  rjmp Main_readButton_L40
Main_readButton_L41:
  movw r26, r4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(47)
  ldi r18, hi8(47)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  sbrc r19, 7
  rjmp CMP_FALSE_23
  mov r16, r17
  or r16, r19
  brne .+2
  rjmp CMP_FALSE_23
  rjmp CMP_TRUE_23
CMP_FALSE_23:
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_23
CMP_TRUE_23:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_23:
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
  rjmp Main_readButton_L42
  movw r26, r4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(58)
  ldi r18, hi8(58)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  sbrc r19, 7
  rjmp CMP_TRUE_24
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_24
CMP_TRUE_24:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_24:
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
  rjmp Main_readButton_L44
  movw r26, r4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(48)
  ldi r18, hi8(48)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  st Y+, r17
  st Y+, r19
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
Main_readButton_L44:
Main_readButton_L42:
  movw r26, r4
  ld r16, X+
  ld r18, X
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
Main_playRound:
  movw r4, r28
  ldi r16, 0
  st Y+, r16
  st Y+, r16
  ldi r16, 0
  st Y+, r16
  st Y+, r16
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
Main_playRound_L46:
  movw r26, r4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  sbrc r19, 7
  rjmp CMP_TRUE_25
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_25
CMP_TRUE_25:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_25:
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
  rjmp Main_playRound_L47
  movw r26, r4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
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
  subi r16, lo8(10)
  sbci r17, hi8(10)
  mov r6, r16
  mov r7, r17
  call Main_stepAt
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  adiw r26, 2
  st X+, r16
  st X, r18
  movw r26, r4
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
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
  subi r16, lo8(10)
  sbci r17, hi8(10)
  mov r6, r16
  mov r7, r17
  call Main_flash
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
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
  rjmp Main_playRound_L46
Main_playRound_L47:
  ldi r16, lo8(0)
  ldi r18, hi8(0)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  st X+, r16
  st X, r18
Main_playRound_L48:
  movw r26, r4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  sbrc r19, 7
  rjmp CMP_TRUE_26
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_26
CMP_TRUE_26:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_26:
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
  rjmp Main_playRound_L49
  movw r26, r4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
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
  subi r16, lo8(10)
  sbci r17, hi8(10)
  mov r6, r16
  mov r7, r17
  call Main_stepAt
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  adiw r26, 2
  st X+, r16
  st X, r18
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
  call Main_readButton
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  adiw r26, 4
  st X+, r16
  st X, r18
  movw r26, r4
  adiw r26, 4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
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
  subi r16, lo8(10)
  sbci r17, hi8(10)
  mov r6, r16
  mov r7, r17
  call Main_flash
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
  movw r26, r4
  adiw r26, 4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r4
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  or r17, r19
  brne .+2
  rjmp CMP_TRUE_27
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_27
CMP_TRUE_27:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_27:
  ld r18, -Y
  ld r16, -Y
  com r16
  com r18
  st Y+, r16
  st Y+, r18
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
  rjmp Main_playRound_L50
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
Main_playRound_L50:
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
  rjmp Main_playRound_L48
Main_playRound_L49:
  ldi r16, lo8(0)
  ldi r18, hi8(0)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  com r16
  com r18
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
Main_gameOver:
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
Main_gameOver_L52:
  movw r26, r4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(6)
  ldi r18, hi8(6)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  sbrc r19, 7
  rjmp CMP_TRUE_28
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_28
CMP_TRUE_28:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_28:
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
  rjmp Main_gameOver_L53
  ldi r16, lo8(16384)
  ldi r18, hi8(16384)
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(15)
  ldi r18, hi8(15)
  st Y+, r16
  st Y+, r18
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
  subi r16, lo8(12)
  sbci r17, hi8(12)
  mov r6, r16
  mov r7, r17
  call Memory_poke
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
  ldi r16, lo8(60)
  ldi r18, hi8(60)
  st Y+, r16
  st Y+, r18
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
  subi r16, lo8(10)
  sbci r17, hi8(10)
  mov r6, r16
  mov r7, r17
  call Sys_wait
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
  ldi r16, lo8(16384)
  ldi r18, hi8(16384)
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(0)
  ldi r18, hi8(0)
  st Y+, r16
  st Y+, r18
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
  subi r16, lo8(12)
  sbci r17, hi8(12)
  mov r6, r16
  mov r7, r17
  call Memory_poke
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
  ldi r16, lo8(60)
  ldi r18, hi8(60)
  st Y+, r16
  st Y+, r18
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
  subi r16, lo8(10)
  sbci r17, hi8(10)
  mov r6, r16
  mov r7, r17
  call Sys_wait
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
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
  rjmp Main_gameOver_L52
Main_gameOver_L53:
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
Main_main:
  movw r4, r28
  ldi r16, 0
  st Y+, r16
  st Y+, r16
  ldi r16, 0
  st Y+, r16
  st Y+, r16
  ldi r16, lo8(1)
  ldi r18, hi8(1)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  st X+, r16
  st X, r18
Main_main_L54:
  ldi r16, lo8(0)
  ldi r18, hi8(0)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  com r16
  com r18
  st Y+, r16
  st Y+, r18
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
  rjmp Main_main_L55
  ldi r16, lo8(150)
  ldi r18, hi8(150)
  st Y+, r16
  st Y+, r18
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
  subi r16, lo8(10)
  sbci r17, hi8(10)
  mov r6, r16
  mov r7, r17
  call Sys_wait
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
  movw r26, r4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
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
  subi r16, lo8(10)
  sbci r17, hi8(10)
  mov r6, r16
  mov r7, r17
  call Main_playRound
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  adiw r26, 2
  st X+, r16
  st X, r18
  movw r26, r4
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
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
  rjmp Main_main_L56
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
  movw r26, r4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(15)
  ldi r18, hi8(15)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  sbrc r19, 7
  rjmp CMP_FALSE_29
  mov r16, r17
  or r16, r19
  brne .+2
  rjmp CMP_FALSE_29
  rjmp CMP_TRUE_29
CMP_FALSE_29:
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_29
CMP_TRUE_29:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_29:
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
  rjmp Main_main_L58
  ldi r16, lo8(15)
  ldi r18, hi8(15)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  st X+, r16
  st X, r18
Main_main_L58:
  rjmp Main_main_L57
Main_main_L56:
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
  call Main_gameOver
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
  ldi r16, lo8(1)
  ldi r18, hi8(1)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  st X+, r16
  st X, r18
Main_main_L57:
  rjmp Main_main_L54
Main_main_L55:
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
Memory_init:
  movw r4, r28
  ldi r16, lo8(0)
  ldi r18, hi8(0)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  sts 512, r16
  sts 513, r18
  ldi r16, lo8(2048)
  ldi r18, hi8(2048)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  sts 514, r16
  sts 515, r18
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
Memory_peek:
  movw r4, r28
  ldi r16, 0
  st Y+, r16
  st Y+, r16
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  st X+, r16
  st X, r18
  movw r26, r4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(0)
  ldi r18, hi8(0)
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
  mov r10, r16
  mov r11, r18
  movw r26, r10
  cpi r27, 0x40
  brsh _MMIO_HI_0
  ld r16, X+
  ld r18, X
  rjmp _MMIO_END_0
_MMIO_HI_0:
  cpi r27, 0x60
  brsh _MMIO_KBD_0
  andi r27, 0x03
  ori r27, 0x04
  ld r16, X
  ldi r18, 0
  rjmp _MMIO_END_0
_MMIO_KBD_0:
  lds r16, 0x0800
  ldi r18, 0
_MMIO_END_0:
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
Memory_poke:
  movw r4, r28
  ldi r16, 0
  st Y+, r16
  st Y+, r16
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  st X+, r16
  st X, r18
  movw r26, r4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(0)
  ldi r18, hi8(0)
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
  movw r26, r6
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
  ld r18, -Y
  ld r16, -Y
  mov r10, r16
  mov r11, r18
  lds r16, 528
  lds r18, 529
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
Memory_alloc:
  movw r4, r28
  ldi r16, 0
  st Y+, r16
  st Y+, r16
  lds r16, 514
  lds r18, 515
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  st X+, r16
  st X, r18
  lds r16, 514
  lds r18, 515
  st Y+, r16
  st Y+, r18
  movw r26, r6
  ld r16, X+
  ld r18, X
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
  sts 514, r16
  sts 515, r18
  movw r26, r4
  ld r16, X+
  ld r18, X
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
Memory_deAlloc:
  movw r4, r28
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
Keyboard_keyPressed:
  movw r4, r28
  ldi r16, lo8(24576)
  ldi r18, hi8(24576)
  st Y+, r16
  st Y+, r18
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
  subi r16, lo8(10)
  sbci r17, hi8(10)
  mov r6, r16
  mov r7, r17
  call Memory_peek
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
Keyboard_readChar:
  movw r4, r28
  ldi r16, 0
  st Y+, r16
  st Y+, r16
Keyboard_readChar_L0:
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
  call Keyboard_keyPressed
  ldi r16, lo8(0)
  ldi r18, hi8(0)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  or r17, r19
  brne .+2
  rjmp CMP_TRUE_30
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_30
CMP_TRUE_30:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_30:
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
  rjmp Keyboard_readChar_L1
  rjmp Keyboard_readChar_L0
Keyboard_readChar_L1:
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
  call Keyboard_keyPressed
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  st X+, r16
  st X, r18
Keyboard_readChar_L2:
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
  call Keyboard_keyPressed
  ldi r16, lo8(0)
  ldi r18, hi8(0)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  or r17, r19
  brne .+2
  rjmp CMP_TRUE_31
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_31
CMP_TRUE_31:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_31:
  ld r18, -Y
  ld r16, -Y
  com r16
  com r18
  st Y+, r16
  st Y+, r18
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
  rjmp Keyboard_readChar_L3
  rjmp Keyboard_readChar_L2
Keyboard_readChar_L3:
  movw r26, r4
  ld r16, X+
  ld r18, X
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
Screen_init:
  movw r4, r28
  ldi r16, lo8(0)
  ldi r18, hi8(0)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  com r16
  com r18
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  sts 512, r16
  sts 513, r18
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
Screen_clearScreen:
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
Screen_clearScreen_L0:
  movw r26, r4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(8192)
  ldi r18, hi8(8192)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  sbrc r19, 7
  rjmp CMP_TRUE_32
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_32
CMP_TRUE_32:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_32:
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
  rjmp Screen_clearScreen_L1
  ldi r16, lo8(16384)
  ldi r18, hi8(16384)
  st Y+, r16
  st Y+, r18
  movw r26, r4
  ld r16, X+
  ld r18, X
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
  ldi r16, lo8(0)
  ldi r18, hi8(0)
  st Y+, r16
  st Y+, r18
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
  subi r16, lo8(12)
  sbci r17, hi8(12)
  mov r6, r16
  mov r7, r17
  call Memory_poke
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
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
  rjmp Screen_clearScreen_L0
Screen_clearScreen_L1:
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
Screen_setColor:
  movw r4, r28
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  sts 512, r16
  sts 513, r18
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
Screen_drawPixel:
  movw r4, r28
  ldi r16, 0
  st Y+, r16
  st Y+, r16
  ldi r16, 0
  st Y+, r16
  st Y+, r16
  ldi r16, 0
  st Y+, r16
  st Y+, r16
  ldi r16, 0
  st Y+, r16
  st Y+, r16
  ldi r16, 0
  st Y+, r16
  st Y+, r16
  ldi r16, lo8(16384)
  ldi r18, hi8(16384)
  st Y+, r16
  st Y+, r18
  movw r26, r6
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(32)
  ldi r18, hi8(32)
  st Y+, r16
  st Y+, r18
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
  subi r16, lo8(12)
  sbci r17, hi8(12)
  mov r6, r16
  mov r7, r17
  call Math_multiply
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  add r16, r17
  adc r18, r19
  st Y+, r16
  st Y+, r18
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(16)
  ldi r18, hi8(16)
  st Y+, r16
  st Y+, r18
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
  subi r16, lo8(12)
  sbci r17, hi8(12)
  mov r6, r16
  mov r7, r17
  call Math_divide
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
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(15)
  ldi r18, hi8(15)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  and r16, r17
  and r18, r19
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  adiw r26, 6
  st X+, r16
  st X, r18
  ldi r16, lo8(1)
  ldi r18, hi8(1)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  adiw r26, 2
  st X+, r16
  st X, r18
  ldi r16, lo8(0)
  ldi r18, hi8(0)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  adiw r26, 8
  st X+, r16
  st X, r18
Screen_drawPixel_L2:
  movw r26, r4
  adiw r26, 8
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r4
  adiw r26, 6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  sbrc r19, 7
  rjmp CMP_TRUE_33
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_33
CMP_TRUE_33:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_33:
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
  rjmp Screen_drawPixel_L3
  movw r26, r4
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r4
  adiw r26, 2
  ld r16, X+
  ld r18, X
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
  adiw r26, 2
  st X+, r16
  st X, r18
  movw r26, r4
  adiw r26, 8
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
  adiw r26, 8
  st X+, r16
  st X, r18
  rjmp Screen_drawPixel_L2
Screen_drawPixel_L3:
  movw r26, r4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
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
  subi r16, lo8(10)
  sbci r17, hi8(10)
  mov r6, r16
  mov r7, r17
  call Memory_peek
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  adiw r26, 4
  st X+, r16
  st X, r18
  lds r16, 512
  lds r18, 513
  st Y+, r16
  st Y+, r18
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
  rjmp Screen_drawPixel_L4
  movw r26, r4
  adiw r26, 4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r4
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  or r16, r17
  or r18, r19
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  adiw r26, 4
  st X+, r16
  st X, r18
  rjmp Screen_drawPixel_L5
Screen_drawPixel_L4:
  movw r26, r4
  adiw r26, 4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r4
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  com r16
  com r18
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  and r16, r17
  and r18, r19
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  adiw r26, 4
  st X+, r16
  st X, r18
Screen_drawPixel_L5:
  movw r26, r4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r4
  adiw r26, 4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
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
  subi r16, lo8(12)
  sbci r17, hi8(12)
  mov r6, r16
  mov r7, r17
  call Memory_poke
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
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
Screen_drawLine:
  movw r4, r28
  movw r26, r6
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r6
  adiw r26, 6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  or r17, r19
  brne .+2
  rjmp CMP_TRUE_34
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_34
CMP_TRUE_34:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_34:
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
  rjmp Screen_drawLine_L6
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r6
  adiw r26, 4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r6
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
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
  subi r16, lo8(14)
  sbci r17, hi8(14)
  mov r6, r16
  mov r7, r17
  call Screen_drawHLine
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
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
Screen_drawLine_L6:
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r6
  adiw r26, 4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  or r17, r19
  brne .+2
  rjmp CMP_TRUE_35
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_35
CMP_TRUE_35:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_35:
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
  rjmp Screen_drawLine_L8
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r6
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r6
  adiw r26, 6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
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
  subi r16, lo8(14)
  sbci r17, hi8(14)
  mov r6, r16
  mov r7, r17
  call Screen_drawVLine
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
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
Screen_drawLine_L8:
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r6
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
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
  subi r16, lo8(12)
  sbci r17, hi8(12)
  mov r6, r16
  mov r7, r17
  call Screen_drawPixel
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
  movw r26, r6
  adiw r26, 4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r6
  adiw r26, 6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
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
  subi r16, lo8(12)
  sbci r17, hi8(12)
  mov r6, r16
  mov r7, r17
  call Screen_drawPixel
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
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
Screen_drawHLine:
  movw r4, r28
  ldi r16, 0
  st Y+, r16
  st Y+, r16
  ldi r16, 0
  st Y+, r16
  st Y+, r16
  ldi r16, 0
  st Y+, r16
  st Y+, r16
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r6
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  sbrc r19, 7
  rjmp CMP_TRUE_36
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_36
CMP_TRUE_36:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_36:
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
  rjmp Screen_drawHLine_L10
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  adiw r26, 2
  st X+, r16
  st X, r18
  movw r26, r6
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  adiw r26, 4
  st X+, r16
  st X, r18
  rjmp Screen_drawHLine_L11
Screen_drawHLine_L10:
  movw r26, r6
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  adiw r26, 2
  st X+, r16
  st X, r18
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  adiw r26, 4
  st X+, r16
  st X, r18
Screen_drawHLine_L11:
  movw r26, r4
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  st X+, r16
  st X, r18
Screen_drawHLine_L12:
  movw r26, r4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r4
  adiw r26, 4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  sbrc r19, 7
  rjmp CMP_FALSE_37
  mov r16, r17
  or r16, r19
  brne .+2
  rjmp CMP_FALSE_37
  rjmp CMP_TRUE_37
CMP_FALSE_37:
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_37
CMP_TRUE_37:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_37:
  ld r18, -Y
  ld r16, -Y
  com r16
  com r18
  st Y+, r16
  st Y+, r18
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
  rjmp Screen_drawHLine_L13
  movw r26, r4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r6
  adiw r26, 4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
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
  subi r16, lo8(12)
  sbci r17, hi8(12)
  mov r6, r16
  mov r7, r17
  call Screen_drawPixel
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
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
  rjmp Screen_drawHLine_L12
Screen_drawHLine_L13:
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
Screen_drawVLine:
  movw r4, r28
  ldi r16, 0
  st Y+, r16
  st Y+, r16
  ldi r16, 0
  st Y+, r16
  st Y+, r16
  ldi r16, 0
  st Y+, r16
  st Y+, r16
  movw r26, r6
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r6
  adiw r26, 4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  sbrc r19, 7
  rjmp CMP_TRUE_38
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_38
CMP_TRUE_38:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_38:
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
  rjmp Screen_drawVLine_L14
  movw r26, r6
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  adiw r26, 2
  st X+, r16
  st X, r18
  movw r26, r6
  adiw r26, 4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  adiw r26, 4
  st X+, r16
  st X, r18
  rjmp Screen_drawVLine_L15
Screen_drawVLine_L14:
  movw r26, r6
  adiw r26, 4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  adiw r26, 2
  st X+, r16
  st X, r18
  movw r26, r6
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  adiw r26, 4
  st X+, r16
  st X, r18
Screen_drawVLine_L15:
  movw r26, r4
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  st X+, r16
  st X, r18
Screen_drawVLine_L16:
  movw r26, r4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r4
  adiw r26, 4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  sbrc r19, 7
  rjmp CMP_FALSE_39
  mov r16, r17
  or r16, r19
  brne .+2
  rjmp CMP_FALSE_39
  rjmp CMP_TRUE_39
CMP_FALSE_39:
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_39
CMP_TRUE_39:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_39:
  ld r18, -Y
  ld r16, -Y
  com r16
  com r18
  st Y+, r16
  st Y+, r18
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
  rjmp Screen_drawVLine_L17
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
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
  subi r16, lo8(12)
  sbci r17, hi8(12)
  mov r6, r16
  mov r7, r17
  call Screen_drawPixel
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
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
  rjmp Screen_drawVLine_L16
Screen_drawVLine_L17:
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
Screen_drawRectangle:
  movw r4, r28
  ldi r16, 0
  st Y+, r16
  st Y+, r16
  movw r26, r6
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  st X+, r16
  st X, r18
Screen_drawRectangle_L18:
  movw r26, r4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r6
  adiw r26, 6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  sbrc r19, 7
  rjmp CMP_FALSE_40
  mov r16, r17
  or r16, r19
  brne .+2
  rjmp CMP_FALSE_40
  rjmp CMP_TRUE_40
CMP_FALSE_40:
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_40
CMP_TRUE_40:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_40:
  ld r18, -Y
  ld r16, -Y
  com r16
  com r18
  st Y+, r16
  st Y+, r18
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
  rjmp Screen_drawRectangle_L19
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r6
  adiw r26, 4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
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
  subi r16, lo8(14)
  sbci r17, hi8(14)
  mov r6, r16
  mov r7, r17
  call Screen_drawHLine
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
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
  rjmp Screen_drawRectangle_L18
Screen_drawRectangle_L19:
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
Output_init:
  movw r4, r28
  ldi r16, lo8(0)
  ldi r18, hi8(0)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  sts 512, r16
  sts 513, r18
  ldi r16, lo8(0)
  ldi r18, hi8(0)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  sts 514, r16
  sts 515, r18
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
Output_moveCursor:
  movw r4, r28
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  sts 514, r16
  sts 515, r18
  movw r26, r6
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  sts 512, r16
  sts 513, r18
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
Output_printChar:
  movw r4, r28
  lds r16, 512
  lds r18, 513
  st Y+, r16
  st Y+, r18
  lds r16, 514
  lds r18, 515
  st Y+, r16
  st Y+, r18
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
  subi r16, lo8(12)
  sbci r17, hi8(12)
  mov r6, r16
  mov r7, r17
  call Screen_drawPixel
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
  lds r16, 512
  lds r18, 513
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(2)
  ldi r18, hi8(2)
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
  sts 512, r16
  sts 513, r18
  lds r16, 512
  lds r18, 513
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(63)
  ldi r18, hi8(63)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  sbrc r19, 7
  rjmp CMP_FALSE_41
  mov r16, r17
  or r16, r19
  brne .+2
  rjmp CMP_FALSE_41
  rjmp CMP_TRUE_41
CMP_FALSE_41:
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_41
CMP_TRUE_41:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_41:
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
  rjmp Output_printChar_L0
  ldi r16, lo8(0)
  ldi r18, hi8(0)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  sts 512, r16
  sts 513, r18
  lds r16, 514
  lds r18, 515
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(2)
  ldi r18, hi8(2)
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
  sts 514, r16
  sts 515, r18
Output_printChar_L0:
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
Output_println:
  movw r4, r28
  ldi r16, lo8(0)
  ldi r18, hi8(0)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  sts 512, r16
  sts 513, r18
  lds r16, 514
  lds r18, 515
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(2)
  ldi r18, hi8(2)
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
  sts 514, r16
  sts 515, r18
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
Output_printInt:
  movw r4, r28
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(0)
  ldi r18, hi8(0)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  sbrc r19, 7
  rjmp CMP_TRUE_42
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_42
CMP_TRUE_42:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_42:
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
  rjmp Output_printInt_L2
  ldi r16, lo8(45)
  ldi r18, hi8(45)
  st Y+, r16
  st Y+, r18
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
  subi r16, lo8(10)
  sbci r17, hi8(10)
  mov r6, r16
  mov r7, r17
  call Output_printChar
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  com r16
  com r18
  subi r16, 0xFF
  sbci r18, 0xFF
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r6
  st X+, r16
  st X, r18
Output_printInt_L2:
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(9)
  ldi r18, hi8(9)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  sbrc r19, 7
  rjmp CMP_FALSE_43
  mov r16, r17
  or r16, r19
  brne .+2
  rjmp CMP_FALSE_43
  rjmp CMP_TRUE_43
CMP_FALSE_43:
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_43
CMP_TRUE_43:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_43:
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
  rjmp Output_printInt_L4
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(10)
  ldi r18, hi8(10)
  st Y+, r16
  st Y+, r18
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
  subi r16, lo8(12)
  sbci r17, hi8(12)
  mov r6, r16
  mov r7, r17
  call Math_divide
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
  subi r16, lo8(10)
  sbci r17, hi8(10)
  mov r6, r16
  mov r7, r17
  call Output_printInt
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
Output_printInt_L4:
  ldi r16, lo8(48)
  ldi r18, hi8(48)
  st Y+, r16
  st Y+, r18
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
  subi r16, lo8(10)
  sbci r17, hi8(10)
  mov r6, r16
  mov r7, r17
  call Output_printChar
  ld r18, -Y
  ld r16, -Y
  sts 528, r16
  sts 529, r18
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
Output_backSpace:
  movw r4, r28
  lds r16, 512
  lds r18, 513
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(0)
  ldi r18, hi8(0)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  sbrc r19, 7
  rjmp CMP_FALSE_44
  mov r16, r17
  or r16, r19
  brne .+2
  rjmp CMP_FALSE_44
  rjmp CMP_TRUE_44
CMP_FALSE_44:
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_44
CMP_TRUE_44:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_44:
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
  rjmp Output_backSpace_L6
  lds r16, 512
  lds r18, 513
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(2)
  ldi r18, hi8(2)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  st Y+, r17
  st Y+, r19
  ld r18, -Y
  ld r16, -Y
  sts 512, r16
  sts 513, r18
Output_backSpace_L6:
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
Math_init:
  movw r4, r28
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
Math_abs:
  movw r4, r28
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(0)
  ldi r18, hi8(0)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  sbrc r19, 7
  rjmp CMP_TRUE_45
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_45
CMP_TRUE_45:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_45:
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
  rjmp Math_abs_L0
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  com r16
  com r18
  subi r16, 0xFF
  sbci r18, 0xFF
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
Math_abs_L0:
  movw r26, r6
  ld r16, X+
  ld r18, X
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
Math_min:
  movw r4, r28
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r6
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  sbrc r19, 7
  rjmp CMP_TRUE_46
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_46
CMP_TRUE_46:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_46:
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
  rjmp Math_min_L2
  movw r26, r6
  ld r16, X+
  ld r18, X
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
Math_min_L2:
  movw r26, r6
  adiw r26, 2
  ld r16, X+
  ld r18, X
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
Math_max:
  movw r4, r28
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r6
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  sbrc r19, 7
  rjmp CMP_TRUE_47
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_47
CMP_TRUE_47:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_47:
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
  rjmp Math_max_L4
  movw r26, r6
  adiw r26, 2
  ld r16, X+
  ld r18, X
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
Math_max_L4:
  movw r26, r6
  ld r16, X+
  ld r18, X
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
Math_multiply:
  movw r4, r28
  ldi r16, 0
  st Y+, r16
  st Y+, r16
  ldi r16, 0
  st Y+, r16
  st Y+, r16
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
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  adiw r26, 2
  st X+, r16
  st X, r18
  ldi r16, lo8(1)
  ldi r18, hi8(1)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  adiw r26, 4
  st X+, r16
  st X, r18
Math_multiply_L6:
  movw r26, r4
  adiw r26, 4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(0)
  ldi r18, hi8(0)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  or r17, r19
  brne .+2
  rjmp CMP_TRUE_48
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_48
CMP_TRUE_48:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_48:
  ld r18, -Y
  ld r16, -Y
  com r16
  com r18
  st Y+, r16
  st Y+, r18
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
  rjmp Math_multiply_L7
  movw r26, r6
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r4
  adiw r26, 4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  and r16, r17
  and r18, r19
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(0)
  ldi r18, hi8(0)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  or r17, r19
  brne .+2
  rjmp CMP_TRUE_49
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_49
CMP_TRUE_49:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_49:
  ld r18, -Y
  ld r16, -Y
  com r16
  com r18
  st Y+, r16
  st Y+, r18
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
  rjmp Math_multiply_L8
  movw r26, r4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r4
  adiw r26, 2
  ld r16, X+
  ld r18, X
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
Math_multiply_L8:
  movw r26, r4
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r4
  adiw r26, 2
  ld r16, X+
  ld r18, X
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
  adiw r26, 2
  st X+, r16
  st X, r18
  movw r26, r4
  adiw r26, 4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r4
  adiw r26, 4
  ld r16, X+
  ld r18, X
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
  adiw r26, 4
  st X+, r16
  st X, r18
  rjmp Math_multiply_L6
Math_multiply_L7:
  movw r26, r4
  ld r16, X+
  ld r18, X
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
Math_divide:
  movw r4, r28
  ldi r16, 0
  st Y+, r16
  st Y+, r16
  ldi r16, 0
  st Y+, r16
  st Y+, r16
  movw r26, r6
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(0)
  ldi r18, hi8(0)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  or r17, r19
  brne .+2
  rjmp CMP_TRUE_50
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_50
CMP_TRUE_50:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_50:
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
  rjmp Math_divide_L10
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
Math_divide_L10:
  ldi r16, lo8(0)
  ldi r18, hi8(0)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  adiw r26, 2
  st X+, r16
  st X, r18
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(0)
  ldi r18, hi8(0)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  sbrc r19, 7
  rjmp CMP_TRUE_51
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_51
CMP_TRUE_51:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_51:
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
  rjmp Math_divide_L12
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  com r16
  com r18
  subi r16, 0xFF
  sbci r18, 0xFF
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r6
  st X+, r16
  st X, r18
  movw r26, r4
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  com r16
  com r18
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  adiw r26, 2
  st X+, r16
  st X, r18
Math_divide_L12:
  movw r26, r6
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(0)
  ldi r18, hi8(0)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  sbrc r19, 7
  rjmp CMP_TRUE_52
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_52
CMP_TRUE_52:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_52:
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
  rjmp Math_divide_L14
  movw r26, r6
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  com r16
  com r18
  subi r16, 0xFF
  sbci r18, 0xFF
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r6
  adiw r26, 2
  st X+, r16
  st X, r18
  movw r26, r4
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  com r16
  com r18
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  adiw r26, 2
  st X+, r16
  st X, r18
Math_divide_L14:
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r6
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
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
  subi r16, lo8(12)
  sbci r17, hi8(12)
  mov r6, r16
  mov r7, r17
  call Math_divideHelper
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  st X+, r16
  st X, r18
  movw r26, r4
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
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
  rjmp Math_divide_L16
  movw r26, r4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  com r16
  com r18
  subi r16, 0xFF
  sbci r18, 0xFF
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
Math_divide_L16:
  movw r26, r4
  ld r16, X+
  ld r18, X
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
Math_divideHelper:
  movw r4, r28
  ldi r16, 0
  st Y+, r16
  st Y+, r16
  movw r26, r6
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  sbrc r19, 7
  rjmp CMP_FALSE_53
  mov r16, r17
  or r16, r19
  brne .+2
  rjmp CMP_FALSE_53
  rjmp CMP_TRUE_53
CMP_FALSE_53:
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_53
CMP_TRUE_53:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_53:
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
  rjmp Math_divideHelper_L18
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
Math_divideHelper_L18:
  movw r26, r6
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(0)
  ldi r18, hi8(0)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  sbrc r19, 7
  rjmp CMP_TRUE_54
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_54
CMP_TRUE_54:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_54:
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
  rjmp Math_divideHelper_L20
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
Math_divideHelper_L20:
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r6
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r6
  adiw r26, 2
  ld r16, X+
  ld r18, X
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
  subi r16, lo8(12)
  sbci r17, hi8(12)
  mov r6, r16
  mov r7, r17
  call Math_divideHelper
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  st X+, r16
  st X, r18
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r4
  ld r16, X+
  ld r18, X
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
  movw r26, r6
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
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
  subi r16, lo8(12)
  sbci r17, hi8(12)
  mov r6, r16
  mov r7, r17
  call Math_multiply
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  st Y+, r17
  st Y+, r19
  movw r26, r6
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  sbrc r19, 7
  rjmp CMP_TRUE_55
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_55
CMP_TRUE_55:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_55:
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
  rjmp Math_divideHelper_L22
  movw r26, r4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r4
  ld r16, X+
  ld r18, X
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
Math_divideHelper_L22:
  movw r26, r4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r4
  ld r16, X+
  ld r18, X
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
Math_sqrt:
  movw r4, r28
  ldi r16, 0
  st Y+, r16
  st Y+, r16
  ldi r16, 0
  st Y+, r16
  st Y+, r16
  ldi r16, 0
  st Y+, r16
  st Y+, r16
  ldi r16, 0
  st Y+, r16
  st Y+, r16
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
  ldi r16, lo8(7)
  ldi r18, hi8(7)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  adiw r26, 2
  st X+, r16
  st X, r18
  ldi r16, lo8(128)
  ldi r18, hi8(128)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  adiw r26, 8
  st X+, r16
  st X, r18
Math_sqrt_L24:
  movw r26, r4
  adiw r26, 2
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(0)
  ldi r18, hi8(0)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  sbrc r19, 7
  rjmp CMP_TRUE_56
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_56
CMP_TRUE_56:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_56:
  ld r18, -Y
  ld r16, -Y
  com r16
  com r18
  st Y+, r16
  st Y+, r18
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
  rjmp Math_sqrt_L25
  movw r26, r4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r4
  adiw r26, 8
  ld r16, X+
  ld r18, X
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
  adiw r26, 4
  st X+, r16
  st X, r18
  movw r26, r4
  adiw r26, 4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r4
  adiw r26, 4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
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
  subi r16, lo8(12)
  sbci r17, hi8(12)
  mov r6, r16
  mov r7, r17
  call Math_multiply
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  adiw r26, 6
  st X+, r16
  st X, r18
  movw r26, r4
  adiw r26, 6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  movw r26, r6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  sbrc r19, 7
  rjmp CMP_FALSE_57
  mov r16, r17
  or r16, r19
  brne .+2
  rjmp CMP_FALSE_57
  rjmp CMP_TRUE_57
CMP_FALSE_57:
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_57
CMP_TRUE_57:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_57:
  ld r18, -Y
  ld r16, -Y
  com r16
  com r18
  st Y+, r16
  st Y+, r18
  movw r26, r4
  adiw r26, 6
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(0)
  ldi r18, hi8(0)
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  sub r17, r16
  sbc r19, r18
  sbrc r19, 7
  rjmp CMP_FALSE_58
  mov r16, r17
  or r16, r19
  brne .+2
  rjmp CMP_FALSE_58
  rjmp CMP_TRUE_58
CMP_FALSE_58:
  ldi r16, 0x00
  ldi r18, 0x00
  st Y+, r16
  st Y+, r18
  rjmp CMP_END_58
CMP_TRUE_58:
  ldi r16, 0xFF
  ldi r18, 0xFF
  st Y+, r16
  st Y+, r18
CMP_END_58:
  ld r18, -Y
  ld r16, -Y
  ld r19, -Y
  ld r17, -Y
  and r16, r17
  and r18, r19
  st Y+, r16
  st Y+, r18
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
  rjmp Math_sqrt_L26
  movw r26, r4
  adiw r26, 4
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  st X+, r16
  st X, r18
Math_sqrt_L26:
  movw r26, r4
  adiw r26, 2
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
  sub r17, r16
  sbc r19, r18
  st Y+, r17
  st Y+, r19
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  adiw r26, 2
  st X+, r16
  st X, r18
  movw r26, r4
  adiw r26, 8
  ld r16, X+
  ld r18, X
  st Y+, r16
  st Y+, r18
  ldi r16, lo8(2)
  ldi r18, hi8(2)
  st Y+, r16
  st Y+, r18
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
  subi r16, lo8(12)
  sbci r17, hi8(12)
  mov r6, r16
  mov r7, r17
  call Math_divide
  ld r18, -Y
  ld r16, -Y
  movw r26, r4
  adiw r26, 8
  st X+, r16
  st X, r18
  rjmp Math_sqrt_L24
Math_sqrt_L25:
  movw r26, r4
  ld r16, X+
  ld r18, X
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
