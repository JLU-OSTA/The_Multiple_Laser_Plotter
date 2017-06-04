#include <reg51.h>  //�������Ŷ���
#include <intrins.h>  //����_nop_����

sbit dir=P2^1;  //����X���ƶ��������
sbit step=P2^0;  //���岽���������ܽ�

void dely(void);  //����y������ʱ10ms
void delx(void);  //����x������ʱ1ms
void delray(void);  //����������ʱ120ms

void main(void)  // ������
{
    int mt[8]={0x11,0x33,0x22,0x66,0x44,0xcc,0x88,0x99};  //y�Ჽ������������飨�������������
    long int i,j;  //���������α���i��j
	P2|=0xFF;  //��ʼ��P2��
    P0=0x00;  //��ʼ��P0��
    dir=0;  //��ʼ��x����ת������
    step=0;  //��step��ֵ0
    P1=0x00;  //��ʼ��P1��
    dir=1;  //����x�����ת
    for(i=0;i<810;i++) //x����󳤶ȣ�����i��ֵ��Ҫ�ⶨ
    {
        step=~step;  //stepȡ��
        delx();  //��ʱ1ms
        if(step)  //�ж������Ƿ����
        {
            delray();  //����ͷ��ʱ120ms
        }
    }
    for(j=0;j<1024;j++)  //y�����󳤶ȣ�����j��ֵ��Ҫ����ⶨ
    {
        for(i=0;i<9;i++)  //��ȡy������������
        {
            P1=mt[8-i];  //��ȡy������������
            dely();  //��ʱ10ms
        }
    }
    dir=0;  //����x������ת
    for(i=0;i<810;i++)  //X����󳤶�
    {
        step=~step; //stepȡ��
        delx();  //��ʱ1ms
        if(step) //�ж������Ƿ����
        {
            delray();  //����ͷ��ʱ120ms
        }
    }
    for(j=0;j<1024;j++)  //y����󳤶�
    {
        for(i=0;i<9;i++)  //��ȡy������������
        {
            P1=mt[i];  //��ȡy������������
            dely();  //��ʱ10ms
        }
    }
	while(1);
}
void dely(void)  //��ʱ10ms�ӳ���
{
	unsign1ed char i, j;

	i = 36;
	j = 217;
	do
	{
		while (--j);
	} while (--i);
}

void delx(void)  //��ʱ1ms�ӳ���
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

void delray(void)  //��ʱ120ms�ӳ���
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
