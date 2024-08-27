    AREA RESET, DATA, READONLY 
    EXPORT __Vectors
__Vectors
    DCD 0x10001000 ; Stack
    DCD Reset_Handler
    ALIGN 

    AREA myarea, CODE, READONLY
    ENTRY 
    EXPORT Reset_Handler

Reset_Handler
    MOV R3, #5
    LDR R0, =SRC
    ADD R2, R0, #36  ; Corrected R1 to R2 for the destination address

BACK 
    LDR R1, [R0]     ; Load value from source array
    LDR R5, [R2]     ; Load value from the end of the array
    STR R5, [R0]     ; Store the value from the end to the start
    STR R1, [R2], #-4 ; Store the value from start to the end and decrement R2
    ADD R0, R0, #4   ; Move to the next element in the source
    SUB R3, R3, #1   ; Decrement loop counter
    CMP R3, #0       ; Compare loop counter with 0
    BNE BACK         ; If not zero, loop again

STOP 
    B STOP           ; Infinite loop to stop execution

    AREA MYDATA, DATA, READWRITE
SRC DCD 0,0,0,0,0,0,0,0,0,0 ; Array of ten 32-bit numbers

    END
