	AREA RESET,DATA ,READONLY
	EXPORT __Vectors
__Vectors
	DCD 0X10001000;stack pointer 
	DCD Reset_Handler;
	ALIGN 
	AREA mycode,CODE,READONLY
	ENTRY 
	EXPORT Reset_Handler
Reset_Handler
	LDR R0,=N
	LDR R1,=DST
	LDR R2,[R0];
	STR R2,[R1];
	ADD R0,#4
	ADD R1,#4
	LDR R2,[R0]
	STR R2,[R1]
STOP
	B STOP 
N	DCD 0X12345678,0X6A
	AREA mydata,DATA,READWRITE
DST	DCD 0,0
	
	END
	