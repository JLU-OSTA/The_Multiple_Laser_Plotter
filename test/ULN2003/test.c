#include <reg51.h>  //包含引脚定义函数

sbit dir=P2^2;  //定义方向控制引脚

void del(void);  //声明延时10ms函数

void main(void)  //主程序
{
    int mt[8]={0x11,0x33,0x22,0x66,0x44,0xcc,0x88,0x99};  //y轴步进电机转动数组
    int i;  //声明变量i
    P1=0x00;  //初始化P1
	P2=0xff;  //初始化P2
	P0=0x00;  //初始化P0；
    while(1)   //死循环
    {
		if(dir==0)  //判断y电机转动方向
		{
            for(i=0;i<9;i++)  //读取数组
            {
                P1=mt[i];  //读取数组
                del();  //延时10ms
            }
		}
		if(dir==1)  //判断y电机转动方向
		{
			for(i=0;i<9;i++)  //读取数组
            {
                P1=mt[8-i];  //读取数组
                del();  //延时10ms
            }
		}
    }
}

void del(void)  //延时10ms子程序
{
	unsigned char i, j;

	i = 36;
	j = 217;
	do
	{
		while (--j);
	} while (--i);
}
