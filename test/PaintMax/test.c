#include <reg51.h>  //包含引脚定义
#include <intrins.h>  //包含_nop_函数

sbit dir=P2^1;  //定义X轴移动方向控制
sbit step=P2^0;  //定义步进电机脉冲管脚

void dely(void);  //声明y轴电机延时10ms
void delx(void);  //声明x轴电机延时1ms
void delray(void);  //声明激光延时120ms

void main(void)  // 主程序
{
    int mt[8]={0x11,0x33,0x22,0x66,0x44,0xcc,0x88,0x99};  //y轴步进电机脉冲数组（两个步进电机）
    long int i,j;  //声明长整形变量i，j
	P2|=0xFF;  //初始化P2口
    P0=0x00;  //初始化P0口
    dir=0;  //初始化x轴电机转动方向
    step=0;  //给step赋值0
    P1=0x00;  //初始化P1口
    dir=1;  //启动x电机反转
    for(i=0;i<810;i++) //x轴最大长度，具体i的值需要测定
    {
        step=~step;  //step取反
        delx();  //延时1ms
        if(step)  //判断脉冲是否完成
        {
            delray();  //激光头延时120ms
        }
    }
    for(j=0;j<1024;j++)  //y轴的最大长度，具体j的值需要具体测定
    {
        for(i=0;i<9;i++)  //读取y轴电机脉冲数组
        {
            P1=mt[8-i];  //读取y轴电机脉冲数组
            dely();  //延时10ms
        }
    }
    dir=0;  //启动x轴电机正转
    for(i=0;i<810;i++)  //X轴最大长度
    {
        step=~step; //step取反
        delx();  //延时1ms
        if(step) //判断脉冲是否完成
        {
            delray();  //激光头延时120ms
        }
    }
    for(j=0;j<1024;j++)  //y轴最大长度
    {
        for(i=0;i<9;i++)  //读取y轴电机脉冲数组
        {
            P1=mt[i];  //读取y轴电机脉冲数组
            dely();  //延时10ms
        }
    }
	while(1);
}
void dely(void)  //延时10ms子程序
{
	unsign1ed char i, j;

	i = 36;
	j = 217;
	do
	{
		while (--j);
	} while (--i);
}

void delx(void)  //延时1ms子程序
{
	unsigned char i, j;

	_nop_();
	i = 4;
	j = 146;
	do
	{
		while (--j);
	} while (--i);
}

void delray(void)  //延时120ms子程序
{
	unsigned char i, j, k;

	_nop_();
	i = 3;
	j = 26;
	k = 223;
	do
	{
		do
		{
			while (--k);
		} while (--j);
	} while (--i);
}
