; BCD MUL 
    AREA RESET, DATA, READONLY 
    EXPORT __Vectors
__Vectors
    DCD 0X10001000       ; Stack pointer initialization
    DCD Reset_Handler    ; Points to the Reset_Handler as the program's entry point
    ALIGN 
    AREA mycode, CODE, READONLY 
    ENTRY 
    EXPORT Reset_Handler 

Reset_Handler
    LDR R0, =BCD1        ; Load the address of the first BCD number
    LDR R1, =BCD2        ; Load the address of the second BCD number
    LDR R2, =RES         ; Load the address where the result will be stored

    LDRB R3, [R0]        ; Load the first BCD number into R3
    LDRB R4, [R1]        ; Load the second BCD number into R4

    MUL R5, R3, R4       ; Multiply the BCD numbers (R5 = R3 * R4)

    BL BCD_ADJUST        ; Adjust the result if necessary to maintain BCD format

    STRB R5, [R2]        ; Store the result in the RES memory location

STOP
    B STOP               ; Infinite loop to stop the program

; BCD Adjustment subroutine
BCD_ADJUST
    MOV R6, R5           ; Copy the result to R6 for adjustment
    AND R7, R6, #0xF     ; Extract the lower nibble (4 bits)
    CMP R7, #0xA         ; Check if the lower nibble is greater than 9
    ADDHS R6, R6, #0x6   ; If so, add 6 to the lower nibble

    AND R7, R6, #0xF0    ; Extract the upper nibble (next 4 bits)
    CMP R7, #0xA0        ; Check if the upper nibble is greater than 9
    ADDHS R6, R6, #0x60  ; If so, add 6 to the upper nibble

    MOV R5, R6           ; Move the adjusted result back to R5
    BX LR                ; Return from the subroutine

BCD1 DCB 0x25            ; BCD number 25 (representing decimal 25)
BCD2 DCB 0x12            ; BCD number 12 (representing decimal 12)
    AREA mydata, DATA, READWRITE 
RES DCB 0x00             ; Reserve space for the result and initialize it to 0
    END 
