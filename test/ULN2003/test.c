#include <reg51.h>  //�������Ŷ��庯��

sbit dir=P2^2;  //���巽���������

void del(void);  //������ʱ10ms����

void main(void)  //������
{
    int mt[8]={0x11,0x33,0x22,0x66,0x44,0xcc,0x88,0x99};  //y�Ჽ�����ת������
    int i;  //��������i
    P1=0x00;  //��ʼ��P1
	P2=0xff;  //��ʼ��P2
	P0=0x00;  //��ʼ��P0��
    while(1)   //��ѭ��
    {
		if(dir==0)  //�ж�y���ת������
		{
            for(i=0;i<9;i++)  //��ȡ����
            {
                P1=mt[i];  //��ȡ����
                del();  //��ʱ10ms
            }
		}
		if(dir==1)  //�ж�y���ת������
		{
			for(i=0;i<9;i++)  //��ȡ����
            {
                P1=mt[8-i];  //��ȡ����
                del();  //��ʱ10ms
            }
		}
    }
}

void del(void)  //��ʱ10ms�ӳ���
{
	unsigned char i, j;

	i = 36;
	j = 217;
	do
	{
		while (--j);
	} while (--i);
}
