//δ�����Ӽ����������ͷ�ļ�
//�����ˣ�����ɡ�����ˡ�����
//����ʱ�䣺2017��4��28��
//MCUʱ�ӣ�22.1184MHz
//ͨ��Э�鶨�壺
//  ��5λ���ڿ����ź�
//  ����λ------����ָ��
//����ָ��壺
//  0x01------����ģʽ����
//  0x02------��ʼ������
//  0x04------ֹͣ����
//  0x03------��ͣ����
//  0x07------���ش��ڵ�������
//  �������ش��ڵ�������

#include "digital_ray_tool.h"  //�������Ƕ���ĺ���

#define FOSC 22118400L  //����ʱ��Ƶ��
#define BAUD 19200  //���崮�ڽ��ղ�����

bit busy;  //����æ��־
int flag=0;  //ָ����Ҫ�����־
char command=0;  //ָ��Ĵ����

void SendData(unsigned char dat);  //����1Byte���ݵ����ж˿�
void SendString(char *s);  //�����ַ��������ж˿�
void terminal();  //ָ��������

void main()  //������ʼ
{
    init_digital_ray_tool();
	P2=0x00;
    SCON = 0xda;  //���ô���ģʽ
    TMOD = 0x20;  //���ö�ʱ������ģʽΪ8λ�Զ���װ�����ڲ���������
    ISP_CMD=0x00;  //STC����ָ��
    ISP_CONTR|=0x81;  //STC���ڿ�����λ
    ISP_TRIG=0x46;  //ʹ��Ӧ��Ч
    ISP_TRIG=0xb9;  //ʹ��Ӧ��Ч
    TH1 = TL1 = -(FOSC/12/32/BAUD);  //��ʱ�������벨����
    TR1 = 1;  //������ʱ��1
    ES = 1;  //���������ж�����
    EA = 1;  //�������ж�����
    while(1)  //ѭ����ȡ�������
	{
		terminal();  //����ָ��
	}
}

void Uart_Isr() interrupt 4 using 1  //�����ж�����
{
    if (RI)  //�����ձ�־
    {
        RI = 0;  //������ձ�־�ȴ�����
        command=SBUF;  //�ӻ�������ȡ����
        flag=1;  //��־������
    }
    if (TI)  //��ⷢ����ɱ�־
    {
        TI = 0;  //������ͱ�־
        busy=0;  //���æ��־
    }
}

void SendData(unsigned char dat)  //���ڷ���1Byte����
{
	while(busy)  //��⴮��æ
        ACC = dat;  //�����ݴ�
    if (P)  //��⴮��ֹͣλҪ��
    {
        TB8 = 1;  //��λֹͣλ
    }
    else  //��ⲻ���ڴ���ֹͣλҪ��ʱ
    {
        TB8 = 0;  //����ֹͣλ
    }
	busy=1;  //��Ǵ���æ
    SBUF = ACC;  //�򴮿ڷ�������
}

void SendString(char *s)  //�򴮿ڷ����ַ���
{
    while (*s)  //���ַ���ָ��ָ��ĵ�ַ�ǿ�ʱ
    {
        SendData(*s++);  //����ָ��ָ���1Byte�ַ�����ʹָ���Լ�1
    }
}

void terminal()  //ָ��������
{
    EA=0;   //�ر����жϣ���ֹ���뱻����
    if(flag)  //���������־
    {
        switch(command&0x07)  //���ָ��λ
        {
            case 0x01:  //�������ģʽ
                {
                    digital_ray_tool(command&0xf8);  //���û�������ͷ�ļ��ṩ�Ŀ��ƺ���
                    break;  //����ƥ��
                }
            case 0x02:  //��ʼ������
                {
                    init_digital_ray_tool();  //���û�������ͷ�ļ��ṩ�Ļ�����ʼ������
                    break;  //����ƥ��
                }
            case 0x03:  //��ͣ����
                {
                    save_digital_ray_tool();  //���û�������ͷ�ļ��ṩ�Ļ�����ͣ����
                    break;  //����ƥ��
                }
            case 0x04:  //ֹͣ����
                {
                    stop_digital_ray_tool();  //���û�������ͷ�ļ��ṩ�Ļ���ֹͣ����
                    break;  //����ƥ��
                }
            case 0x07:  //���ش���ͨ��״̬
                {
					EA=1;	//���ж������Ա�ظ���Ϣ
                    SendString("The Serial Port is OK!\r\n");  //��ӡ����״̬��Ϣ
                    SendString("BAUD:19200\nFOSC:22.1184MHz\r\n");  //��ӡ����״̬��Ϣ
                    SendString("Made by WeiMingming team.\r\n");  //��ӡ�Ŷ���Ϣ
                    SendString("Author:JinYifei,FengDelang,ZhaoQi.\r\n");  //��ӡ������Ϣ
                    SendString("That is all.\r\n");  //��ӡ��ֹ��Ϣ
                    break;  //����ƥ��
                }
            default:    //ƥ��һ�����
                {
                    break;  //��ִ���κβ����˳�
                }
        }
        flag=0;  //����������־
    }
    EA=1;   //�������ж�����λ
}
