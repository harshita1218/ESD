    AREA RESET, DATA, READONLY 
    EXPORT __Vectors 
__Vectors
    DCD 0x10001000 ; Stack
    DCD Reset_Handler
    ALIGN 

    AREA mycode, CODE, READONLY 
    ENTRY
    EXPORT Reset_Handler

Reset_Handler
    MOV R2, #0
    LDR R0, =VALUE1
    LDR R1, [R0]
    LDR R0, =VALUE2
    LDR R3, [R0]

up
    SUB R1, R3
    ADD R2, #1
    CMP R1, R3
    BCS up

    LDR R6, =RESULT
    STR R2, [R6, #4]
    STR R1, [R6]

STOP
    B STOP

VALUE1 DCD 0x20 ; First 32-bit number
VALUE2 DCD 0x5  ; Second 16-bit number

    AREA data, DATA, READWRITE
RESULT DCD 0, 0

    END
	
	; division of 2 32 bit numbers 
	