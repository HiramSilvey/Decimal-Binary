    AREA asm_func, CODE, READONLY
    EXPORT reset_leds
reset_leds
    LDR     R0, =0x2009C000 ; Store the GPIO port 0 base address in R1
    MOV.W   R1, #0x6000000  ; Initialize R3 with 1's in the 25th and 26th bit positions
    STR     R1, [R0, #0x1C] ; Turn OFF the LEDs corresponding to the 25th and 26th bit positions
    
    LDR     R0, =0x2009C020 ; Store the GPIO port 1 base address in R1
    MOV.W   R1, #0xC0000000 ; Initialize R3 with 1's in the 30th and 31st bit positions
    STR     R1, [R0, #0x1C] ; Turn OFF the LEDs corresponding to the 30th and 31st bit positions
    
    LDR     R0, =0x2009C040 ; Store the GPIO port 2 base address in R1
    MOV.W   R1, #0x3F       ; Initialize R3 with 1's in the 0th, 1st, 2nd, 3rd, 4th, and 5th bit positions
    STR     R1, [R0, #0x1C] ; Turn OFF the LEDs corresponding to the 0th, 1st, 2nd, 3rd, 4th, and 5th bit positions

    BX      LR              ; Branch and change instruction set
    ALIGN                   ; Add padding to align bits
    END