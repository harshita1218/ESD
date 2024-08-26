	AREA RESET,DATA, READONLY 
	EXPORT __Vectors
__Vectors
	DCD 0X10001000;STACK
	DCD Reset_Handler
	ALIGN 
	AREA mycode,CODE,READONLY
	ENTRY 
	EXPORT Reset_Handler
Reset_Handler
	LDR R0,=SRC+4*(N-1)
	LDR R1,=SRC+4*(N-1+shift)
	MOV R3,#0XA
BACK 
	LDR R4,[R0],#-4
	STR R4,[R1],#-4
	SUB R3,#1
	CMP R3,#0
	BNE BACK 
STOP B STOP
N EQU 10 
shift EQU 2
	AREA mycode,CODE,READWRITE 
SRC DCD 0,0,0,0,0,0,0,0,0,0
	END


;When the source and destination blocks are overlapping 