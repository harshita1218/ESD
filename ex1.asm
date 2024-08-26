	AREA RESET, DATA,READONLY 
	EXPORT __Vectors 
__Vectors
	DCD 0x10001000;stack 
	DCD Reset_Handler;
	ALIGN 
	AREA mycode,CODE,READONLY 
	ENTRY 
	EXPORT Reset_Handler
Reset_Handler
	LDR R0,=SRC;Load address of src into R0
	LDR R1,=DST;load the address of dst onto r1
	LDR R3,[R0];load data pointed by r0 into r3
	STR R3,[R1];store dara from r3 into the address pointed by r1
STOP B STOP
SRC DCD 8,0X123456;
	AREA DATASEG,DATA,READWRITE
DST DCD 0;
	END 
;Write a ARM assembly language program to copy 16 bit variable from code 
;memory to data memory.  