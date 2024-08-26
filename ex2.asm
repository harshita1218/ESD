	AREA RESET,DATA,READONLY 
	EXPORT __Vectors
__Vectors
	DCD 0x10001000;stack
	DCD Reset_Handler
	ALIGN 
	AREA mycode,CODE ,READONLY
	ENTRY
	EXPORT Reset_Handler
Reset_Handler
	LDR R0,=N
	LDR R1,=DST
	MOV R3,#10
BACK
	STR R1,[R2],#4
	SUB R3,#1
	CMP R3,#0
	BNE BACK 
STOP B STOP 
N DCD 0X21,0X34,0XF2,0XEA3,0X5432,0XE345,0XCA4,0X54,0XF3,0XBE2
	AREA mydata , DATA, READWRITE  
DST DCD 0,0,0,0,0,0,0,0,0,0
	END
;Write an ARM assembly language program to transfer block of ten 32 bit numbers 
;from one memory to another  
;a. When the source and destination blocks are non-overlapping