//未命名队激光机床驱动头文件
//著作人：金翼飞、丰德浪、赵琦
//制作时间：2017年4月28日
//MCU时钟：22.1184MHz
//引脚定义：
//  P2.0------x轴轨道电机步进脉冲
//  P2.1------x轴轨道电机运行方向控制
//  P2.2------激光开关控制(高电平有效)
//  P1.*------y轴轨道电机步进输出
//参数(5位)数据结构：由高到低
//  x电机参数------2位  00-关  10-x坐标增加  01-x坐标减少
//  y电机参数------2位  00-关  10-y坐标增加  01-y坐标减少
//  激光开关-------1位  0-关   1-开
//  低三位用于串口指令下发
//注意：初次使用需要先复位轨道，并刷写附带提供的ROM文件。

//#include <reg51.h>  //提供单片机寄存器定义，已经包含在stc89c5xrc.h中
#include <intrins.h>  //提供nop函数
#include <stc89c5xrc.h>  //提供STC89C52RC专用寄存器定义

#define y_motor_define P2  //定义y轴电机驱动引脚(使用该管脚低4位)
#define max_x 400  //定义最大横轴坐标
#define max_y 900  //定义最大纵轴坐标

sbit xdir=P2^1;  //定义x轴电机方向控制引脚
sbit xstep=P2^0;  //定义x轴电机步进引脚
sbit ray_ctl=P2^2;  //定义激光开光控制引脚(反相控制)
int y_motor_step[8]={0x10,0x30,0x20,0x60,0x40,0xc0,0x80,0x90};  //定义y轴步进电机数组
int ray_x,ray_y;   //定义横纵坐标记录变量,可用数据：0-65535

void delay_motor_y(void);  //y轴电机延时函数10ms
void delay_motor_x(void);  //x轴电机延时函数1ms
void init_digital_ray_tool(void);  //机床初始化函数原型
void digital_ray_tool(char digital_ray_tool_control);  //数字机床控制函数原型
void save_digital_ray_tool(void);  //机床安全暂停函数原型
void stop_digital_ray_tool(void);  //机床安全停机函数原型
void eraserompage(unsigned int n);  //ROM擦除函数原型
void writerombyte(unsigned int addh,unsigned int addl, unsigned char wdata);  //ROM写入函数原型
unsigned int readrombyte(unsigned int addh,unsigned int addl);  //ROM读取函数原型

void init_digital_ray_tool(void)  //机床初始化函数
{
    int i;  //复位循环变量
    P1&=0xf0;   //初始化P1必要的管脚电平
    P2&=0xf8;  //初始化所有必要的管脚电平
    ray_ctl=0;  //初始化激光头
    ray_x=0;  //初始化x轴运动寄存器变量
    ray_y=0;  //初始化y轴运动寄存器变量
    ray_x=0x100*readrombyte(0x20,0x00)|readrombyte(0x20,0x01);  //读取x轴运动位置记录，2Byte
    ray_y=0x100*readrombyte(0x20,0x02)|readrombyte(0x20,0x03);  //读取y轴运动位置记录，2Byte
    for(i=ray_x;i>1;i--)  //x轴轨道电机复位循环
    {
        digital_ray_tool(0x40);  //x轨道电机回归一个步进
    }
    for(i=ray_y;i>1;i--)  //y轴轨道电机复位循环
    {
        digital_ray_tool(0x10);  //y轨道电机回归一个步进
    }
}

void stop_digital_ray_tool(void)  //机床停机程序
{
	int i;  //复位循环变量
	for(i=ray_x;i>1;i--)  //x轴轨道电机复位循环.
    {
        digital_ray_tool(0x40);  //x轨道电机回归一个步进
    }
    for(i=ray_y;i>1;i--)  //y轴轨道电机复位循环
    {
        digital_ray_tool(0x10);  //y轨道电机回归一个步进
    }
	save_digital_ray_tool();  //清零坐标数据
}

void save_digital_ray_tool(void)  //机床安全暂停程序
{
    P1&=0xf0;   //清除y轴电机干扰因素
    P2&=0xf8;  //清除x各种控制电平
    ray_ctl=0;  //初始化激光器
    eraserompage(1);  //擦除单片机内部EEPROM
    writerombyte(0x20,0x00,ray_x/0x100);  //保存当前x轨道坐标的高8位
    writerombyte(0x20,0x01,ray_x%0x100);  //保存当前x轨道坐标的低8位
    writerombyte(0x20,0x02,ray_y/0x100);  //保存当前y轨道坐标的高8位
    writerombyte(0x20,0x03,ray_y%0x100);  //保存当前y轨道坐标的低8位
}

void digital_ray_tool(char digital_ray_tool_control)  //数字机床控制程序
{
	int j;  //定义读y轨道电机控制数组变量
	char tmp;
    if((digital_ray_tool_control&0x08)!=0)  //判断激光头开关控制位
    {
        ray_ctl=1;  //打开激光头
    }
    else  //检测到激光头开关控制位置低
    {
        ray_ctl=0;  //关闭激光头
    }
    if(((digital_ray_tool_control&0x80)!=0)&&(ray_x<max_x))  //判断x坐标增加控制位与x轨道是否允许此次位移
    {
        xdir=0;  //调整x轨道电机运动方向
        xstep=1;  //给出x轨道电机控制脉冲的上升沿
        delay_motor_x();  //等待电机响应
        ray_x++;  //记录x轨道位置坐标
        xstep=0;  //给出x轨道电机控制脉冲的下降沿
    }
    if(((digital_ray_tool_control&0x40)!=0)&&(ray_x>1))  //判断x坐标减少控制位与x轨道是否允许此次位移
    {
        xdir=1;  //调整x轨道电机运动方向
        xstep=1;  //给出x轨道电机控制脉冲的上升沿
        delay_motor_x();  //等待电机响应
        ray_x--;  //记录x轨道位置坐标
        xstep=0;  //给出x轨道电机控制脉冲的下降沿
    }
    if(((digital_ray_tool_control&0x20)!=0)&&(ray_y<max_y))  //判断y坐标增加控制位与y轨道是否允许此次位移
    {
        for(j=0;j<8;j++)  //读取y轨道步进电机运动数组
        {
            tmp=y_motor_define&0x0f;    //寄存变量
			y_motor_define=tmp|y_motor_step[j];  //正向读取数组中的相应位
        	delay_motor_y();  //等待电机响应
		}
		y_motor_define&=0x0f;	//清空电机
        ray_y++;  //记录y轨道位置坐标
    }
    if(((digital_ray_tool_control&0x10)!=0)&&(ray_y>1))  //判断y坐标减少控制位与y轨道是否允许此次位移
    {
        for(j=0;j<8;j++)  //读取y轨道步进电机运动数组
        {
            tmp=y_motor_define&0x0f;    //寄存变量
			y_motor_define=tmp|y_motor_step[8-j];  //逆向读取数组中的相应位
        	delay_motor_y();  //等待电机响应
		}
		y_motor_define&=0x0f;	//清空电机
        ray_y--;  //记录y轨道位置坐标
    }
}

unsigned int readrombyte(unsigned int addh,unsigned int addl)  //读取STC89C52RC的1Byte EEPROM
{
    EA=0;  //关闭总中断控制，防止读取被中断
    ISP_ADDRH=addh;  //送高地址
    ISP_ADDRL=addl;  //送低地址
    ISP_CMD=0X01;  //读取控制指令
    ISP_TRIG=0x46;  //EEPROM响应
    ISP_TRIG=0xb9;  //EEPROM响应
    EA=1;  //读取完成，恢复中断控制
    return ISP_DATA;  //返回读取到的数据
}

void writerombyte(unsigned int addh,unsigned int addl, unsigned char wdata)  //向STC89C52RC的EEPROM中写入1Byte数据
{
    EA=0;  //关闭总中断控制，防止写入被中断
    ISP_ADDRH=addh;  //送高地址
    ISP_ADDRL=addl;  //送低地址
    ISP_DATA=wdata;  //送数据
    ISP_CMD=0X02;  //写入控制指令
    ISP_TRIG=0x46;  //EEPROM响应
    ISP_TRIG=0xb9;  //EEPROM响应
    EA=1;  //写入完成，恢复中断控制
}

void eraserompage(unsigned int n)  //擦除STC89C52RC的EEPROM中指定页
{
    EA=0;  //关闭总中断控制，防止擦除被中断
    ISP_ADDRH=(n-1)*2+0x20;  //计算指定页起始地址高位
    ISP_ADDRL=0;  //送低地址
    ISP_CMD=0x03;  //擦除控制指令
    ISP_TRIG=0x46;  //EEPROM响应
    ISP_TRIG=0xb9;  //EEPROM响应
    EA=1;  //擦除完成，恢复中断控制
}

void delay_motor_y(void)  //y轴电机控制延时10ms
{
	unsigned char i, j;

	i = 36;
	j = 217;
	do
	{
		while (--j);
	} while (--i);
}

void delay_motor_x(void)  //x轴电机控制延时1ms
{
	unsigned char i, j;

	i = 72;
	j = 181;
	do
	{
		while (--j);
	} while (--i);
}
