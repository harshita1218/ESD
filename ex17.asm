;armstrong 
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
    LDR R0, =NUM         ; Load the address of the number to check
    LDR R1, =RES         ; Load the address where the result will be stored

    LDR R0, [R0]         ; Load the number into R0
    MOV R2, #0           ; Initialize sum R2 to 0

    ; Extract the hundreds digit
    MOV R3, R0
    LSR R3, R3, #8       ; Right shift to get the hundreds digit in R3
    AND R3, R3, #0xFF    ; Mask out the unwanted bits
    BL POW3              ; Calculate the cube of the digit
    ADD R2, R2, R4       ; Add the cube to the sum

    ; Extract the tens digit
    MOV R3, R0
    LSR R3, R3, #4       ; Right shift to get the tens digit in R3
    AND R3, R3, #0xF     ; Mask out the unwanted bits
    BL POW3              ; Calculate the cube of the digit
    ADD R2, R2, R4       ; Add the cube to the sum

    ; Extract the ones digit
    AND R3, R0, #0xF     ; Mask out all but the ones digit in R3
    BL POW3              ; Calculate the cube of the digit
    ADD R2, R2, R4       ; Add the cube to the sum

    ; Compare the sum with the original number
    CMP R2, R0
    BNE NOT_ARMSTRONG    ; If they are not equal, it's not an Armstrong number

    ; Store 1 in the result location to indicate it's an Armstrong number
    MOV R4, #1
    STR R4, [R1]
    B END

NOT_ARMSTRONG
    ; Store 0 in the result location to indicate it's not an Armstrong number
    MOV R4, #0
    STR R4, [R1]

END
STOP
    B STOP               ; Infinite loop to stop the program

POW3
    ; This subroutine calculates R4 = R3^3
    MUL R4, R3, R3       ; R4 = R3^2
    MUL R4, R4, R3       ; R4 = R3^3
    BX LR                ; Return from subroutine

NUM DCD 0x153            ; Number to check (153 is an Armstrong number)
    AREA mydata, DATA, READWRITE 
RES DCD 0x0              ; Result location, 1 = Armstrong, 0 = not
    END 
