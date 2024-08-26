; mul usin rep add 
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
    LDR R0, =SRC1        ; Load the address of the first number (multiplicand)
    LDR R1, =SRC2        ; Load the address of the second number (multiplier)
    LDR R2, =RES         ; Load the address where the result will be stored

    LDR R0, [R0]         ; Load the first number (multiplicand) into R0
    LDR R1, [R1]         ; Load the second number (multiplier) into R1

    MOV R3, #0           ; Initialize the result register R3 to 0
    MOV R4, R1           ; Copy the multiplier into R4 for loop counting

MULTIPLY
    CMP R4, #0           ; Check if the multiplier is 0
    BEQ END              ; If multiplier is 0, end the loop
    ADD R3, R3, R0       ; Add the multiplicand to the result
    SUBS R4, R4, #1      ; Decrement the multiplier
    BNE MULTIPLY         ; If multiplier is not 0, repeat the process

END
    STR R3, [R2]         ; Store the result in the memory location RES

STOP
    B STOP               ; Infinite loop to stop the program

SRC1 DCD 0x00000005      ; First 32-bit number (multiplicand)
SRC2 DCD 0x00000003      ; Second 32-bit number (multiplier)
    AREA mydata, DATA, READWRITE 
RES DCD 0x00000000       ; Reserve space for the result and initialize it to 0
    END 
