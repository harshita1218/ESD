	AREA RESET, DATA, READONLY
	EXPORT __Vectors
__Vectors
	DCD 0x10000000 ;stack 
	DCD Reset_Handler ;reset vecotrs
	ALIGN
	AREA mycode,CODE,READONLY
	ENTRY
	EXPORT Reset_Handler
Reset_Handler
	MOV R2,#0X34
	MOV R4,#0X16
	ADD R1,R4,0XCD
STOP B STOP
	AREA mydata, DATA, READWRITE
	END
	