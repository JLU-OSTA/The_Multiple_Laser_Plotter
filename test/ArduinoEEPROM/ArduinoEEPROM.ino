#include <Wire.h>	//提供IIC定义
#include "i2cEEPROM.h"	//提供IIC上的EEPROM操作函数

void setup()	//初始化程序
{
  i2cEEPROM.begin(0x50);	//片选
  byte num = i2cEEPROM.readByte(0)+1;	//读取1字节rom并自加1
  i2cEEPROM.writeByte(0,num);	//写入自加后的值
  delay(10);	//等待写入完成
  Serial.begin(19200);	//启动串口
}
void loop()		//循环执行
{
  Serial.println(i2cEEPROM.readByte(0));	//读取1字节rom并输出
  delay(1000);	//等待1s
}
