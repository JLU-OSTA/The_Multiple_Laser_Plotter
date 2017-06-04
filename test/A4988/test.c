#include <reg51.h>   //�����Ĵ�������
#include <intrins.h>  //����_nop_����

sbit dir=P2^1;   //�������x����ת��ܽ�
sbit step=P2^0;  //���������������ת���ܽ�

void del(void);  //��ʱ1ms
void delray(void);  //��ʱ120ms

int main(void)  //������
{
    int i;  //����ѭ������
	P2|=0xFF;  //��ʼ��P2��
    P0=0x00;  //��ʼ��P0��
    dir=0;  //����ת��
    step=0;  //��step��ֵΪ0
	for(i=0;i<200;i++)  //�����ƶ�����
    {
       	step=~step;   //��stepȡ��
       	del();   //��ʱ1ms
       	if(step)   //�ж������Ƿ����
            delray();  //����ͷ��ʱ120ms
   	}
	while(1);
}

void del(void)   //��ʱ1ms�ӳ���
{
	unsigned char i, j;

	i = 18;
	j = 235;
	do
	{
		while (--j);
	} while (--i);
}
void delray(void)  //��ʱ120ms�ӳ���
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
