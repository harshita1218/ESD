    AREA RESET, READONLY
    EXPORT __Vectors
__Vectors
    DCD 0X10001000          ; STACK
    DCD Reset_Handler       ; Reset Handler
    ALIGN 
	AREA mycode, CODE, READONLY
    ENTRY
    EXPORT Reset_Handler

Reset_Handler
    LDR R0, =VALUE1         ; Load address of VALUE1 into R0
    LDR R1, [R0]            ; Load value at address R0 into R1
    LDR R0, =VALUE2         ; Load address of VALUE2 into R0
    LDR R3, [R0]            ; Load value at address R0 into R3
    MUL R6, R1, R3          ; Multiply R1 and R3, store result in R6
    LDR R2, =RESULT         ; Load address of RESULT into R2
    STR R6, [R2]            ; Store the result in memory

STOP
    B STOP                  ; Infinite loop
VALUE1 DCD 0X1234           ; Define VALUE1
VALUE2 DCD 0X5678           ; Define VALUE2
	AREA mydata, DATA, READWRITE
RESULT DCD 0                ; Define RESULT

    END
;MULTIPLY 2 32 BIT NUMBERS
