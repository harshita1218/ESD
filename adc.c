#include <LPC17xx.h>
#include <stdio.h>

//Assume P0.27 for RS
//P0.28 for Enable
//P0.26 to P0.23 for input lines

int temp1, temp2, flag1, flag2;

void port_write()
{
	int i;
	LPC_GPIO0->FIOPIN = temp2 << 23;
	
	if(flag1 == 0)
		LPC_GPIO0->FIOCLR = 1 << 27;
	else
		LPC_GPIO0->FIOSET = 1 << 27;
	
	LPC_GPIO0->FIOSET = 1 << 28;
	for(i = 0; i<50; i++);
	LPC_GPIO0->FIOCLR = 1 << 28;
	
	for(i = 0; i<30000; i++);
}

void LCD_write()
{
	if((flag1 == 0) & ((temp1 == 0x30) || (temp1 == 0x20)))
		flag2 = 1;
	else
		flag2 = 0;
	//flag2 = (flag1 == 1) ? 0 :((temp1 == 0x30) || (temp1 == 0x20)) ? 1 : 0;
	temp2 = temp1 >> 4;
	port_write();
	
	if(flag2 == 0)
	{
		temp2 = temp1 & 0xF;
		port_write();
	}
}

int main()
{
	int adc_temp;
	double in_vtg;
	double ref_vtg = 3.3;
	char dval[50], vtg[50];
	int i;
	
	char l1[] = "Analog IP: ";
	char l2[] = "ADC OP: ";
	int lcd_init[] = {0x30, 0x30, 0x30, 0x20, 0x28, 0x0C, 0x01, 0x80, 0x06};
	SystemInit();
	SystemCoreClockUpdate();
	

	LPC_SC->PCONP |= 1<<15; //Power for the GPIO block
	LPC_SC->PCONP |= 1<<12; //enable the peripheral ADC

	LPC_PINCON -> PINSEL1 = 0;
	LPC_PINCON -> PINSEL3 = 3<<30; //P1.31 in func 3 for AD0.5
	
	LPC_GPIO0 -> FIODIR = 0xF << 23 | 1 << 27 | 1 << 28;
	
	
	flag1 = 0;
	for(i = 0; i<=8; i++)
	{
		temp1 = lcd_init[i];
		LCD_write();
	}
	
	//line 1 writing
	flag1 = 0;
	temp1 = 0x80;
	LCD_write();
	flag1 = 1;
	for(i = 0; l1[i]!='\0'; i++)
	{
		temp1 = l1[i];
		LCD_write();
	}
	
	//line 2 writing
	flag1 = 0;
	temp1 = 0xC0;
	LCD_write();
	flag1 = 1;
	for(i = 0; l2[i]!='\0'; i++)
	{
		temp1 = l2[i];
		LCD_write();
	}
	
	while(1)
	{
		LPC_ADC -> ADCR = 1<<5 | 1<< 21 | 1 <<24 ;
		
		while(!((LPC_ADC -> ADGDR)>>31 & 1));
		
		adc_temp = LPC_ADC -> ADGDR;
		adc_temp = (adc_temp >> 4) & 0xFFF;
		
		in_vtg = (((float) adc_temp * (float) ref_vtg)/((float) 0xFFF));
		
		sprintf(vtg, "%3.2fV", in_vtg);
		sprintf(dval, "%x", adc_temp);
		
		flag1 = 0;
		temp1 = 0x8B;
		LCD_write();
		flag1 = 1;
		for(i = 0; vtg[i]!='\0'; i++)
		{
			temp1 = vtg[i];
			LCD_write();
		}
		
		flag1 = 0;
		temp1 = 0xC8;
		LCD_write();
		flag1 = 1;
		for(i = 0; dval[i]!='\0'; i++)
		{
			temp1 = dval[i];
			LCD_write();
		}
	}
	
	
	/*
	flag1 = 1;
	//temp1=0x41;
	//LCD_write();
	for(i = 0; s[i]!='\0'; i++)
	{
		if(i == 16)
		{
			flag1 = 0;
			temp1 = 0xC0;
			LCD_write();
			flag1 = 1;
		}
		temp1 = (int) s[i];
		LCD_write();
	}
	while(1);
	*/
}
