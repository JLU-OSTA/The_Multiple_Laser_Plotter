#include <EtherCard.h>  //包含ENC28J60操作函数

#define STATIC 1  //置1用来启用静态IP地址

#if STATIC    //检测静态IP是否启用
    static byte localeip[] = { 49,140,49,10 };    //本地IP地址
    static byte gateware[] = { 49,140,49,81};    //网关设置
#endif

static byte localemac[] = { 0x74,0x69,0x69,0x2D,0x30,0x31 };    //设置本机MAC地址
byte Ethernet::buffer[500];    //TCP/IP协议缓冲区大小
const char page[] PROGMEM = //HTTP报文构造
    "HTTP/1.0 503 Service Unavailable\r\n"  //HTTP版本及状态码
    "Content-Type: text/html\r\n"   //HTTP报文类型相应头
    "Retry-After: 600\r\n"  //HTTP报文尝试延时
    "\r\n"  //报文切换
    "<html>"    //超文本传输协议开始
        "<head><title>" //超文本传输协议协议头部及标题
            "Arduino Test Page" //网站标题
        "</title></head>"   //超文本传输协议头部及标题结束
        "<body>"    //超文本传输协议内容开始
            "<h3>Hello world!</h3>"
            "<p><em>"
            "Made by JinYifei.<br />"
            "</em></p>"
        "</body>"   //超文本传输协议内容结束
    "</html>"   //超文本传输协议结束
    ;

void setup()    //启动初始化函数，用于配置网络
{
    Serial.begin(9600);   //初始化串行口并配置波特率为9600

    Serial.println("\n[Processing...]");   //向串口打印一个测试信息
//****调试用，调试完成后清除

    if(ether.begin(sizeof Ethernet::buffer, localemac,SS) == 0) //检测网络设备是否配置完成

        Serial.println( "Failed to configure Ethernet hardware.");  //提示设备设置错误
//****调试用，调试完成后清除

    #if STATIC  //检测静态IP配置
        ether.staticSetup(localeip, gateware);  //配置静态IP地址和网关
    #else   //非静态设置下接收动态IP配置
        if (!ether.dhcpSetup())    //检测DHCP配置情况

            Serial.println("DHCP failed");  //当DHCP配置失败时显示错误信息
//****调试用，调试完成后清除

    #endif

    ether.printIp("IP:  ", ether.myip);   //打印设备IP地址
    ether.printIp("GW:  ", ether.gwip);   //打印设备网关地址
    ether.printIp("DNS: ", ether.dnsip);  //打印DNS服务器地址
//****调试用，调试完成后清除

}

void loop() //重复执行部分
{
    if(ether.packetLoop(ether.packetReceive()))    //循环重复读取网络报文
    {
        memcpy_P(ether.tcpOffset(), page, sizeof page); //复制报文内容到TCP缓冲区
        ether.httpServerReply(sizeof page - 1); //发送报文
    }
}
