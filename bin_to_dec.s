    AREA asm_func, CODE, READONLY
    EXPORT bin_to_dec
bin_to_dec
    LDR     R1, =0x2009C000 ; Store the GPIO port 0 base address in R1
    MOV.W   R2, #0x0        ; Initialize R2 with all 0's
    
    SUB     R0, R0, #0x1        ; Subtract 1 from value
    ADD     R2, R2, #0x2000000  ; Make the 25th bit position in R2 = 1
    CMP     R0, #0              ; If value = 0, set and exit
    BEQ     set1

    SUB     R0, R0, #0x1        ; Subtract 1 from value
    ADD     R2, R2, #0x4000000  ; Make the 26th bit position in R2 = 1
    
set1
    STR     R2, [R1, #0x18] ; Turn on the LEDs corresponding to the two bit positions
    CMP     R0, #0          ; If value = 0, exit
    BEQ     exit
    
    LDR     R1, =0x2009C020 ; Store the GPIO port 1 base address in R1
    MOV.W   R2, #0x0        ; Initialize R2 with all 0's
    
    SUB     R0, R0, #0x1        ; Subtract 1 from value
    ADD     R2, R2, #0x40000000 ; Make the 30th bit position in R2 = 1
    CMP     R0, #0              ; If value = 0, set and exit
    BEQ     set2
    
    SUB     R0, R0, #0x1        ; Subtract 1 from value
    ADD     R2, R2, #0x80000000 ; Make the 31st bit position in R2 = 1
    
set2        
    STR     R2, [R1, #0x18] ; Turn on the LEDs corresponding to the two bit positions
    CMP     R0, #0          ; If value = 0, set and exit
    BEQ     exit
    
    LDR     R1, =0x2009C040 ; Store the GPIO port 2 base address in R1
    MOV.W   R2, #0x0        ; Initialize R2 with all 0's
    
    SUB     R0, R0, #0x1    ; Subtract 1 from value
    ADD     R2, R2, #0x1    ; Make the 0th bit position in R2 = 1
    CMP     R0, #0          ; If value = 0, set and exit
    BEQ     set3
    
    SUB     R0, R0, #0x1    ; Subtract 1 from value
    ADD     R2, R2, #0x2    ; Make the 1st bit position in R2 = 1
    CMP     R0, #0          ; If value = 0, set and exit
    BEQ     set3
    
    SUB     R0, R0, #0x1    ; Subtract 1 from value
    ADD     R2, R2, #0x4    ; Make the 2nd bit position in R2 = 1
    CMP     R0, #0          ; If value = 0, set and exit
    BEQ     set3
    
    SUB     R0, R0, #0x1    ; Subtract 1 from value
    ADD     R2, R2, #0x8    ; Make the 3rd bit position in R2 = 1
    CMP     R0, #0          ; If value = 0, set and exit
    BEQ     set3
    
    SUB     R0, R0, #0x1    ; Subtract 1 from value
    ADD     R2, R2, #0x10   ; Make the 4th bit position in R2 = 1
    CMP     R0, #0          ; If value = 0, set and exit
    BEQ     set3
    
    SUB     R0, R0, #0x1    ; Subtract 1 from value
    ADD     R2, R2, #0x20   ; make the 5th bit position in R2 = 1
    
set3        
    STR     R2, [R1, #0x18] ; Turn on the LEDs corresponding to the six bit positions
    
exit
    BX      LR              ; Branch and change instruction set
    ALIGN                   ; Add padding to align bits
    END