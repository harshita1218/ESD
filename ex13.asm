; gcd 
	AREA RESET, DATA,READONLY 
	EXPORT __Vectors
__Vectors
	DCD 0X10001000;STACK
	DCD Reset_Handler 
	ALIGN 
	AREA mycode,CODE,READONLY 
	ENTRY 
	EXPORT Reset_Handler 
Reset_Handler 
	LDR R0,=SRC1
	LDR R1,=SRC2 
	LDR R2,=RES 
	LDR R0,[R0]
	LDR R1,[R1]
UP 
	CMP R0,R1 
	BEQ EXIT 
	SUBHI R0,R1
	SUBLO R1,R0 
	B UP 
EXIT STR R1,[R1]
STOP 
	B STOP 
SRC1 DCD 0X9 
SRC2 DCD 0X6 
	AREA MYDATA , DATA , READWRITE 
RES DCD 0
	END 