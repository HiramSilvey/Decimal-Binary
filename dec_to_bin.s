    AREA asm_func, CODE, READONLY
    EXPORT dec_to_bin
dec_to_bin
    LDR     R1, =0x2009C000 ; Store the GPIO port 0 base address in R1
    MOV.W   R3, #0x0        ; Initialize R3 with all 0's
    
    AND     R2, R0, 0x1     ; Store the lowest order bit from value in R2
    CMP     R2, #0          ; If R2 != 0, then make the 25th bit position in R3 = 1
    ADDNE   R3, #0x2000000
    
    AND     R2, R0, 0x2     ; Store 2nd lowest order bit from value in R2
    CMP     R2, #0          ; If R2 != 0, then make the 26th bit position in R3 = 1
    ADDNE   R3, R3, #0x4000000
    
        ; R3 should have the 2 lowest binary bits of value represented in the 25th and 26th bit positions
        
    STR     R3, [R1, #0x18]   ; Turn on the LEDs corresponding to the two bit positions
    
    LDR     R1, =0x2009C020 ; Store the GPIO port 1 base address in R1
    MOV.W   R3, #0x0        ; Initialize R3 with all 0's
    
    AND     R2, R0, 0x4     ; Store 3rd lowest order bit from value in R2
    CMP     R2, #0          ; If R2 != 0, then make the 30th bit position in R3 = 1
    ADDNE   R3, R3, #0x40000000
    
    AND     R2, R0, 0x8     ; Store 4th lowest order bit from value in R2
    CMP     R2, #0          ; If R2 != 0, then make the 31st bit position in R3 = 1
    ADDNE   R3, R3, #0x80000000
    
        ; R3 should have the next 2 lowest binary bits of value represented in the 30th and 31st bit positions
        
    STR     R3, [R1, #0x18]   ; Turn on the LEDs corresponding to the two bit positions
    
    LDR     R1, =0x2009C040 ; Store the GPIO port 2 base address in R1
    MOV.W   R3, #0x0        ; Initialize R3 with all 0's
    
    AND     R2, R0, 0x10    ; Store 5th lowest order bit from value in R2
    CMP     R2, #0          ; If R2 != 0, then make the 0th bit position in R3 = 1
    ADDNE   R3, R3, #0x1
    
    AND     R2, R0, 0x20    ; Store 6th lowest order bit from value in R2
    CMP     R2, #0          ; If R2 != 0, then make the 1st bit position in R3 = 1
    ADDNE   R3, R3, #0x2
    
    AND     R2, R0, 0x40    ; Store 7th lowest order bit from value in R2
    CMP     R2, #0          ; If R2 != 0, then make the 2nd bit position in R3 = 1
    ADDNE   R3, R3, #0x4
    
    AND     R2, R0, 0x80    ; Store 8th lowest order bit from value in R2
    CMP     R2, #0          ; If R2 != 0, then make the 3rd bit position in R3 = 1
    ADDNE   R3, R3, #0x8
    
    AND     R2, R0, 0x100   ; Store 9th lowest order bit from value in R2
    CMP     R2, #0          ; If R2 != 0, then make the 4th bit position in R3 = 1
    ADDNE   R3, R3, #0x10
    
    AND     R2, R0, 0x200   ; Store 10th lowest order bit from value in R2
    CMP     R2, #0          ; If R2 != 0, then make the 5th bit position in R3 = 1
    ADDNE   R3, R3, #0x20
    
        ; R3 should have the next 6 lowest binary bits of value represented in the 5th, 4th, 3rd, 2nd, 1st, and 0th bit positions
        
    STR     R3, [R1, #0x18] ; Turn on the LEDs corresponding to the six bit positions

    BX      LR              ; Branch and change instruction set
    ALIGN                   ; Add padding to align bits
    END