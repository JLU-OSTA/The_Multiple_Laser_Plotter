//δ�����Ӽ����������ͷ�ļ�
//�����ˣ�����ɡ�����ˡ�����
//����ʱ�䣺2017��4��28��
//MCUʱ�ӣ�22.1184MHz
//���Ŷ��壺
//  P2.0------x���������������
//  P2.1------x����������з������
//  P2.2------���⿪�ؿ���(�ߵ�ƽ��Ч)
//  P1.*------y��������������
//����(5λ)���ݽṹ���ɸߵ���
//  x�������------2λ  00-��  10-x��������  01-x�������
//  y�������------2λ  00-��  10-y��������  01-y�������
//  ���⿪��-------1λ  0-��   1-��
//  ����λ���ڴ���ָ���·�
//ע�⣺����ʹ����Ҫ�ȸ�λ�������ˢд�����ṩ��ROM�ļ���

//#include <reg51.h>  //�ṩ��Ƭ���Ĵ������壬�Ѿ�������stc89c5xrc.h��
#include <intrins.h>  //�ṩnop����
#include <stc89c5xrc.h>  //�ṩSTC89C52RCר�üĴ�������

#define y_motor_define P2  //����y������������(ʹ�øùܽŵ�4λ)
#define max_x 400  //��������������
#define max_y 900  //���������������

sbit xdir=P2^1;  //����x���������������
sbit xstep=P2^0;  //����x������������
sbit ray_ctl=P2^2;  //���弤�⿪���������(�������)
int y_motor_step[8]={0x10,0x30,0x20,0x60,0x40,0xc0,0x80,0x90};  //����y�Ჽ���������
int ray_x,ray_y;   //������������¼����,�������ݣ�0-65535

void delay_motor_y(void);  //y������ʱ����10ms
void delay_motor_x(void);  //x������ʱ����1ms
void init_digital_ray_tool(void);  //������ʼ������ԭ��
void digital_ray_tool(char digital_ray_tool_control);  //���ֻ������ƺ���ԭ��
void save_digital_ray_tool(void);  //������ȫ��ͣ����ԭ��
void stop_digital_ray_tool(void);  //������ȫͣ������ԭ��
void eraserompage(unsigned int n);  //ROM��������ԭ��
void writerombyte(unsigned int addh,unsigned int addl, unsigned char wdata);  //ROMд�뺯��ԭ��
unsigned int readrombyte(unsigned int addh,unsigned int addl);  //ROM��ȡ����ԭ��

void init_digital_ray_tool(void)  //������ʼ������
{
    int i;  //��λѭ������
    P1&=0xf0;   //��ʼ��P1��Ҫ�Ĺܽŵ�ƽ
    P2&=0xf8;  //��ʼ�����б�Ҫ�Ĺܽŵ�ƽ
    ray_ctl=0;  //��ʼ������ͷ
    ray_x=0;  //��ʼ��x���˶��Ĵ�������
    ray_y=0;  //��ʼ��y���˶��Ĵ�������
    ray_x=0x100*readrombyte(0x20,0x00)|readrombyte(0x20,0x01);  //��ȡx���˶�λ�ü�¼��2Byte
    ray_y=0x100*readrombyte(0x20,0x02)|readrombyte(0x20,0x03);  //��ȡy���˶�λ�ü�¼��2Byte
    for(i=ray_x;i>1;i--)  //x���������λѭ��
    {
        digital_ray_tool(0x40);  //x�������ع�һ������
    }
    for(i=ray_y;i>1;i--)  //y���������λѭ��
    {
        digital_ray_tool(0x10);  //y�������ع�һ������
    }
}

void stop_digital_ray_tool(void)  //����ͣ������
{
	int i;  //��λѭ������
	for(i=ray_x;i>1;i--)  //x���������λѭ��.
    {
        digital_ray_tool(0x40);  //x�������ع�һ������
    }
    for(i=ray_y;i>1;i--)  //y���������λѭ��
    {
        digital_ray_tool(0x10);  //y�������ع�һ������
    }
	save_digital_ray_tool();  //������������
}

void save_digital_ray_tool(void)  //������ȫ��ͣ����
{
    P1&=0xf0;   //���y������������
    P2&=0xf8;  //���x���ֿ��Ƶ�ƽ
    ray_ctl=0;  //��ʼ��������
    eraserompage(1);  //������Ƭ���ڲ�EEPROM
    writerombyte(0x20,0x00,ray_x/0x100);  //���浱ǰx�������ĸ�8λ
    writerombyte(0x20,0x01,ray_x%0x100);  //���浱ǰx�������ĵ�8λ
    writerombyte(0x20,0x02,ray_y/0x100);  //���浱ǰy�������ĸ�8λ
    writerombyte(0x20,0x03,ray_y%0x100);  //���浱ǰy�������ĵ�8λ
}

void digital_ray_tool(char digital_ray_tool_control)  //���ֻ������Ƴ���
{
	int j;  //�����y�����������������
	char tmp;
    if((digital_ray_tool_control&0x08)!=0)  //�жϼ���ͷ���ؿ���λ
    {
        ray_ctl=1;  //�򿪼���ͷ
    }
    else  //��⵽����ͷ���ؿ���λ�õ�
    {
        ray_ctl=0;  //�رռ���ͷ
    }
    if(((digital_ray_tool_control&0x80)!=0)&&(ray_x<max_x))  //�ж�x�������ӿ���λ��x����Ƿ�����˴�λ��
    {
        xdir=0;  //����x�������˶�����
        xstep=1;  //����x���������������������
        delay_motor_x();  //�ȴ������Ӧ
        ray_x++;  //��¼x���λ������
        xstep=0;  //����x����������������½���
    }
    if(((digital_ray_tool_control&0x40)!=0)&&(ray_x>1))  //�ж�x������ٿ���λ��x����Ƿ�����˴�λ��
    {
        xdir=1;  //����x�������˶�����
        xstep=1;  //����x���������������������
        delay_motor_x();  //�ȴ������Ӧ
        ray_x--;  //��¼x���λ������
        xstep=0;  //����x����������������½���
    }
    if(((digital_ray_tool_control&0x20)!=0)&&(ray_y<max_y))  //�ж�y�������ӿ���λ��y����Ƿ�����˴�λ��
    {
        for(j=0;j<8;j++)  //��ȡy�����������˶�����
        {
            tmp=y_motor_define&0x0f;    //�Ĵ����
			y_motor_define=tmp|y_motor_step[j];  //�����ȡ�����е���Ӧλ
        	delay_motor_y();  //�ȴ������Ӧ
		}
		y_motor_define&=0x0f;	//��յ��
        ray_y++;  //��¼y���λ������
    }
    if(((digital_ray_tool_control&0x10)!=0)&&(ray_y>1))  //�ж�y������ٿ���λ��y����Ƿ�����˴�λ��
    {
        for(j=0;j<8;j++)  //��ȡy�����������˶�����
        {
            tmp=y_motor_define&0x0f;    //�Ĵ����
			y_motor_define=tmp|y_motor_step[8-j];  //�����ȡ�����е���Ӧλ
        	delay_motor_y();  //�ȴ������Ӧ
		}
		y_motor_define&=0x0f;	//��յ��
        ray_y--;  //��¼y���λ������
    }
}

unsigned int readrombyte(unsigned int addh,unsigned int addl)  //��ȡSTC89C52RC��1Byte EEPROM
{
    EA=0;  //�ر����жϿ��ƣ���ֹ��ȡ���ж�
    ISP_ADDRH=addh;  //�͸ߵ�ַ
    ISP_ADDRL=addl;  //�͵͵�ַ
    ISP_CMD=0X01;  //��ȡ����ָ��
    ISP_TRIG=0x46;  //EEPROM��Ӧ
    ISP_TRIG=0xb9;  //EEPROM��Ӧ
    EA=1;  //��ȡ��ɣ��ָ��жϿ���
    return ISP_DATA;  //���ض�ȡ��������
}

void writerombyte(unsigned int addh,unsigned int addl, unsigned char wdata)  //��STC89C52RC��EEPROM��д��1Byte����
{
    EA=0;  //�ر����жϿ��ƣ���ֹд�뱻�ж�
    ISP_ADDRH=addh;  //�͸ߵ�ַ
    ISP_ADDRL=addl;  //�͵͵�ַ
    ISP_DATA=wdata;  //������
    ISP_CMD=0X02;  //д�����ָ��
    ISP_TRIG=0x46;  //EEPROM��Ӧ
    ISP_TRIG=0xb9;  //EEPROM��Ӧ
    EA=1;  //д����ɣ��ָ��жϿ���
}

void eraserompage(unsigned int n)  //����STC89C52RC��EEPROM��ָ��ҳ
{
    EA=0;  //�ر����жϿ��ƣ���ֹ�������ж�
    ISP_ADDRH=(n-1)*2+0x20;  //����ָ��ҳ��ʼ��ַ��λ
    ISP_ADDRL=0;  //�͵͵�ַ
    ISP_CMD=0x03;  //��������ָ��
    ISP_TRIG=0x46;  //EEPROM��Ӧ
    ISP_TRIG=0xb9;  //EEPROM��Ӧ
    EA=1;  //������ɣ��ָ��жϿ���
}

void delay_motor_y(void)  //y����������ʱ10ms
{
	unsigned char i, j;

	i = 36;
	j = 217;
	do
	{
		while (--j);
	} while (--i);
}

void delay_motor_x(void)  //x����������ʱ1ms
{
	unsigned char i, j;

	i = 72;
	j = 181;
	do
	{
		while (--j);
	} while (--i);
}
