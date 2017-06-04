#include <EtherCard.h>  //包含ENC28J60操作函数
#include <Wire.h>   //包含IIC协议
#include "i2cEEPROM.h"    //包含IIC协议EEPROM操作函数

byte Ethernet::buffer[500];    //TCP/IP协议缓冲区大小

const char page[] PROGMEM =   //HTTP报文构造
    "HTTP/1.0 WeiMingming Team\r\n"  //HTTP版本及状态码
    "Content-Type: text/html\r\n"   //HTTP报文类型相应头
    "Retry-After: 600\r\n"  //HTTP报文尝试延时
    "\r\n"  //报文切换
    "<html>"    //超文本传输协议开始
        "<head><title>" //超文本传输协议协议头部及标题
            "WeiMingming Ray Painter" //网站标题
        "</title></head>"   //超文本传输协议头部及标题结束
        "<body>"    //超文本传输协议内容开始
            "<h3>Welcome to ues our ray painter!</h3>"
            "<p><em>"
            "<br />This machine was made by WeiMingming team.<br />"
            "When using it, you should obey our opensource protocol.<br />"
            "Happy using!<br />"
            "<br />Authors: JinYifei,FengDelang,ZhaoQi<br />"
            "Time: Apr-28-2017<br />"
            "</em></p>"
        "</body>"   //超文本传输协议内容结束
    "</html>"   //超文本传输协议结束
    ;

void setup()    //启动初始化函数，用于配置网络
{
    byte localeip[4],gateware[4],localemac[6];  //寄存配置信息
    int i;  //定义循环变量
    Serial.begin(19200);   //初始化串行口并配置波特率为9600
    i2cEEPROM.begin(0x50);  //选择0号存储器
    delay(10);    //等待选择操作完成
    byte STATIC = i2cEEPROM.readByte(0x00);   //读取DHCP使能情况
    delay(10);    //等待写入
    if(STATIC)    //检测静态IP是否启用
    {
        for(i=0x01;i<=0x04;i++)   //读取IP地址设置
        {
            localeip[i-0x01]=i2cEEPROM.readByte(i);   //读取1字节IP地址
            delay(10);    //等待读取完成
        }
        for(i=0x05;i<=0x08;i++)   //读取网关设置
        {
            gateware[i-0x05]=i2cEEPROM.readByte(i);   //读取1字节网关地址
            delay(10);    //等待读取完成
        }
    }
    for(i=0x09;i<=0x0e;i++)   //读取MAC地址
    {
        localemac[i-0x09]=i2cEEPROM.readByte(i);    //读取1字节MAC地址
        delay(10);    //等待读取完成
    }
    ether.begin(sizeof Ethernet::buffer, localemac,SS); //网络设备配置
    if(STATIC)  //检测静态IP配置
        ether.staticSetup(localeip, gateware);  //配置静态IP地址和网关
    else    //检测动态IP配置
        ether.dhcpSetup();    //DHCP配置
}

void loop() //重复执行部分
{
    int i;
    word len = ether.packetReceive();   //接收网络缓存中的数据
    word pos = ether.packetLoop(len);   //回传数据并返回其长度
    if(pos)   //检测数据是否为空
    {
        char* data = (char *) Ethernet::buffer + pos;   //将数据送入data变量指向的指针中
        if(strncmp("GET",data,3)==0)    //检测HTTP请求头部
        {
            memcpy_P(ether.tcpOffset(), page, sizeof page); //复制报文内容到TCP缓冲区
            ether.httpServerReply(sizeof page - 1); //发送报文
        }
        else if (strncmp("G",data,1)==0)   //检测协议头
        {
            Serial.print(data[1]);    //串口打印报文内容
        }
        if (strncmp("C",data,1)==0)   //检测协议头
        {
            i2cEEPROM.begin(0x50);  //选择0号存储器
            delay(10);  //等待设置
            for(i=0x00;i<=0x0e;i++)   //存储配置
            {
                i2cEEPROM.writeByte(i,data[i+0x01]);    //存储1字节配置信息
                delay(10);  //等待存储完成
            }
        }           
    }
}
