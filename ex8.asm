; Add 10 32 bit numbers in code segment and store result in data segment
	AREA RESET,DATA,READONLY 
	EXPORT __Vectors
__Vectors
	DCD 0X10001000;
	DCD Reset_Handler;
	ALIGN 
	AREA mycode,CODE,READONLY
	ENTRY 
	EXPORT Reset_Handler
Reset_Handler
	LDR R0,=SRC1
	LDR R1,=RES
	MOV R2,#10
UP
	LDR R3,[R0],#4
	ADDS R4,R3
	ADC R5,#0
	SUB R2 , #1
	TEQ R2,#0
	BNE UP 
	
	STR R4,[R1],#4
	STR R5,[R1]
STOP
	B STOP 
SRC1 DCD 0XF45A734D,0XFF,0XFFD,0XEED,0X34E,0X33ED,0X4FF,0X2CCC,0XCCB,0X2AA
	AREA MYDATA,DATA,READWRITE 
RES DCD 0,0
	END 
	
	