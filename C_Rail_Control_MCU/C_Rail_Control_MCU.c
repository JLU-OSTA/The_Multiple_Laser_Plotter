//未命名队激光机床驱动头文件
//著作人：金翼飞、丰德浪、赵琦
//制作时间：2017年4月28日
//MCU时钟：22.1184MHz
//通信协议定义：
//  高5位用于控制信号
//  低三位------控制指令
//控制指令定义：
//  0x01------控制模式启用
//  0x02------初始化机床
//  0x04------停止机床
//  0x03------暂停机床
//  0x07------返回串口调试数据
//  其他返回串口调试数据

#include "digital_ray_tool.h"  //包含我们定义的函数

#define FOSC 22118400L  //定义时钟频率
#define BAUD 19200  //定义串口接收波特率

bit busy;  //串口忙标志
int flag=0;  //指令需要处理标志
char command=0;  //指令寄存变量

void SendData(unsigned char dat);  //发送1Byte数据到串行端口
void SendString(char *s);  //发送字符串到串行端口
void terminal();  //指令解码程序

void main()  //主程序开始
{
    init_digital_ray_tool();
	P2=0x00;
    SCON = 0xda;  //设置串口模式
    TMOD = 0x20;  //设置定时器工作模式为8位自动重装，用于产生波特率
    ISP_CMD=0x00;  //STC控制指令
    ISP_CONTR|=0x81;  //STC串口控制置位
    ISP_TRIG=0x46;  //使响应生效
    ISP_TRIG=0xb9;  //使响应生效
    TH1 = TL1 = -(FOSC/12/32/BAUD);  //向定时器中送入波特率
    TR1 = 1;  //启动定时器1
    ES = 1;  //启动串口中断允许
    EA = 1;  //启动总中断允许
    while(1)  //循环读取治疗你给
	{
		terminal();  //解码指令
	}
}

void Uart_Isr() interrupt 4 using 1  //串口中断例程
{
    if (RI)  //检测接收标志
    {
        RI = 0;  //清除接收标志等待处理
        command=SBUF;  //从缓冲区读取数据
        flag=1;  //标志待处理
    }
    if (TI)  //检测发送完成标志
    {
        TI = 0;  //清除发送标志
        busy=0;  //清除忙标志
    }
}

void SendData(unsigned char dat)  //串口发送1Byte数据
{
	while(busy)  //检测串口忙
        ACC = dat;  //数据暂存
    if (P)  //检测串口停止位要求
    {
        TB8 = 1;  //置位停止位
    }
    else  //监测不存在串口停止位要求时
    {
        TB8 = 0;  //清零停止位
    }
	busy=1;  //标记串口忙
    SBUF = ACC;  //向串口发送数据
}

void SendString(char *s)  //向串口发送字符串
{
    while (*s)  //当字符串指针指向的地址非空时
    {
        SendData(*s++);  //发送指针指向的1Byte字符，并使指针自加1
    }
}

void terminal()  //指令解码程序
{
    EA=0;   //关闭总中断，防止解码被干扰
    if(flag)  //检测待解码标志
    {
        switch(command&0x07)  //检测指令位
        {
            case 0x01:  //进入控制模式
                {
                    digital_ray_tool(command&0xf8);  //调用机床控制头文件提供的控制函数
                    break;  //跳出匹配
                }
            case 0x02:  //初始化机床
                {
                    init_digital_ray_tool();  //调用机床控制头文件提供的机床初始化函数
                    break;  //跳出匹配
                }
            case 0x03:  //暂停机床
                {
                    save_digital_ray_tool();  //调用机床控制头文件提供的机床暂停函数
                    break;  //跳出匹配
                }
            case 0x04:  //停止机床
                {
                    stop_digital_ray_tool();  //调用机床控制头文件提供的机床停止函数
                    break;  //跳出匹配
                }
            case 0x07:  //返回串口通信状态
                {
					EA=1;	//打开中断允许，以便回复信息
                    SendString("The Serial Port is OK!\r\n");  //打印串口状态信息
                    SendString("BAUD:19200\nFOSC:22.1184MHz\r\n");  //打印串口状态信息
                    SendString("Made by WeiMingming team.\r\n");  //打印团队信息
                    SendString("Author:JinYifei,FengDelang,ZhaoQi.\r\n");  //打印作者信息
                    SendString("That is all.\r\n");  //打印终止信息
                    break;  //跳出匹配
                }
            default:    //匹配一般情况
                {
                    break;  //不执行任何操作退出
                }
        }
        flag=0;  //清除待处理标志
    }
    EA=1;   //启动总中断允许位
}
