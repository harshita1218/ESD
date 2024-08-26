        AREA RESET, DATA, READONLY
        EXPORT __Vectors
__Vectors
        DCD 0x20001000      ; Stack pointer value
        DCD Reset_Handler   ; Reset vector
        ALIGN

        AREA mycode, CODE, READONLY
        ENTRY
        EXPORT Reset_Handler
Reset_Handler
        LDR R0, =ARRAY      ; Load the address of the array into R0
        LDR R1, =TARGET     ; Load the address of the target value into R1
        LDR R1, [R1]        ; Load the target value into R1
        MOV R2, #10         ; Load the number of elements in the array into R2
        MOV R3, #0          ; Initialize the index register R3 to 0

Loop
        LDR R4, [R0, R3, LSL #2] ; Load the current element of the array into R4
        CMP R4, R1          ; Compare the current element with the target value
        BEQ Found           ; If they are equal, jump to Found
        ADD R3, R3, #1      ; Increment the index register
        CMP R3, R2          ; Compare the index with the number of elements
        BNE Loop            ; If not all elements are checked, continue the loop

Not_Found
        MOV R3, #-1         ; If the element is not found, set R3 to -1
        B Store_Result      ; Jump to store the result

Found
        B Store_Result      ; Jump to store the result

Store_Result
        LDR R0, =RESULT     ; Load the address of the result variable
        STR R3, [R0]        ; Store the result (index or -1) in memory

STOP
        B STOP              ; Infinite loop to end the program

        
ARRAY   DCD 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xA  ; The array of 10 32-bit numbers
TARGET  DCD 0x7
; The value to search for in the array
	AREA mydata, DATA, READWRITE

RESULT  DCD 0              ; Memory location to store the result (index or -1)
        END
