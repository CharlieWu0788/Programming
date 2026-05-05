; test_leds.S
; lights up 0101 pattern to verify all 4 LEDs
; bit 0 on PC0 because PB0 row has phantom voltage
; if you see two LEDs on and two off, all four work

#include <avr/io.h>

.global main
main:
    ldi r16, 0x0E
    out _SFR_IO_ADDR(DDRB), r16   
    ldi r16, 0x01
    out _SFR_IO_ADDR(DDRC), r16   、
    ldi r16, 0x04                   
    out _SFR_IO_ADDR(PORTB), r16
    ldi r16, 0x01                  
    out _SFR_IO_ADDR(PORTC), r16
halt:
    rjmp halt
