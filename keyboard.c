#include <LPC17xx.h>
int main()
{ int x;int col=0;int keycode; int i;int j;
	int seven_seg[]={0X3F,0X06,0X5B,0X4F,0X66,0X60,0X7D,0X07,0X7F,0X6F,0x77,0x7F,0X39,0X3F,0X97,0X71};
	SystemInit();
	SystemCoreClockUpdate();
	LPC_PINCON->PINSEL0=0;
	LPC_PINCON->PINSEL1=0;
	LPC_PINCON->PINSEL3=0;
	LPC_PINCON->PINSEL4=0;
	
	LPC_GPIO0->FIODIR=0XF<<15|0XFF<<4;
	LPC_GPIO1->FIODIR=0;
	LPC_GPIO2->FIODIR=0XF<<10;
	LPC_GPIO0->FIOPIN=0;
	
	while(1)
	{
	  for( i=0;i<4;i++)
        {
					LPC_GPIO2->FIOPIN=1<<(10+i);
					for(j=0;j<1000;j++);
					x=LPC_GPIO1->FIOPIN;
					for(j=0;j<10000;j++);
					x=(x>>23)&0XF ;
					if(x!=0)
					{
						if(x==8)
							col=3;
						else if(x==4)
							col=2;
						else if(x==2)
							col=1;
						else if(x==1)
							col=0;
				
				
		keycode=4*i+col;}
	  LPC_GPIO0->FIOMASK=0XFFFFF00F;
		LPC_GPIO0->FIOPIN=seven_seg[keycode]<<4;		
		for(j=0;j<1000000;j++);
	}
	
}
}
