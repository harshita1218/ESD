	AREA RESET,DATA,READONLY 
	EXPORT __Vectors
__Vectors
	DCD 0X10001000;STACK
	DCD Reset_Handler;
	ALIGN 
	AREA mycode,CODE,READONLY
	ENTRY 
	EXPORT Reset_Handler 
Reset_Handler
	LDR R0,=VALUE1;pointer to the forst value 1 
	LDR R1,[R0] ; load the first value into R1
	LDR R0,=VALUE2; PONTER TO VALUE2 
	LDR R3,[R0]
	ADDS R6,R1,R3
	LDR R2,=RESULT 
	STR R6,[R2]
STOP
	B STOP 
VALUE1 DCD 0X12345678
VALUE2 DCD 0XABCDEF12
	AREA mydata,DATA,READWRITE
RESULT DCD 0 
	END 
;add 2 32 bit numbers
