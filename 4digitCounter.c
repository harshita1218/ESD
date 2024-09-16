#include<LPC17xx.h>
int main()
{
	int n=1234;
	//int count=0;
	int temp; 
	int i;
	int j;
	int seven_seg[]={0X3F,0X06,0X5B,0X4F,0X66,0X6D,0X7D,0X07,0X7F,0X6F,0X77,0X7F,0X39,0X3F,0X97,0X71};
	
	SystemInit();
	SystemCoreClockUpdate();
  LPC_PINCON->PINSEL0=0;
  LPC_PINCON->PINSEL3=0;
  LPC_GPIO0->FIODIR=0xFF<<4;
  LPC_GPIO1->FIODIR=0xF<<23;
	while(1)
	{
		temp=n;
		for(i=0;i<4;i++)
		{
			LPC_GPIO1->FIOPIN=i<<23;
			LPC_GPIO0->FIOPIN=seven_seg[temp%10]<<4;
			temp=temp/10;
			for(j=0;j<10000;j++);
		}
	}
}

