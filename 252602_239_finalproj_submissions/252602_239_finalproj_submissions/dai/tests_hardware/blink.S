; blink.S
; blinks LED bit 0 (now on PC0) to verify hardware
; if it blinks, chip is alive

#include <avr/io.h>

.global main
main:
    ldi r16, 0x01
    out _SFR_IO_ADDR(DDRC), r16   
loop:
    ; LED on
    sbi _SFR_IO_ADDR(PORTC), 0   
    rcall delay
    ; LED off
    cbi _SFR_IO_ADDR(PORTC), 0  
    rcall delay
    rjmp loop

; ghetto delay loop, roughly half a second at 16MHz
delay:
    ldi r24, 0
    ldi r25, 0
    ldi r26, 6
delay_loop:
    subi r24, 1
    sbci r25, 0
    sbci r26, 0
    brne delay_loop
    ret
