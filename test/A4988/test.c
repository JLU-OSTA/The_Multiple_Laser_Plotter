#include <reg51.h>   //包含寄存器定义
#include <intrins.h>  //包含_nop_函数

sbit dir=P2^1;   //定义控制x轴电机转向管脚
sbit step=P2^0;  //定义驱动步进电机转动管脚

void del(void);  //延时1ms
void delray(void);  //延时120ms

int main(void)  //主程序
{
    int i;  //声明循环变量
	P2|=0xFF;  //初始化P2口
    P0=0x00;  //初始化P0口
    dir=0;  //控制转向
    step=0;  //给step赋值为0
	for(i=0;i<200;i++)  //设置移动距离
    {
       	step=~step;   //将step取反
       	del();   //延时1ms
       	if(step)   //判断脉冲是否完成
            delray();  //激光头延时120ms
   	}
	while(1);
}

void del(void)   //延时1ms子程序
{
	unsigned char i, j;

	i = 18;
	j = 235;
	do
	{
		while (--j);
	} while (--i);
}
void delray(void)  //延时120ms子程序
{
	unsigned char i, j, k;

	_nop_();
	i = 2;
	j = 103;
	k = 147;
	do
	{
		do
		{
			while (--k);
		} while (--j);
	} while (--i);
}
