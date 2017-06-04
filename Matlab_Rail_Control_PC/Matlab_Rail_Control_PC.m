function varargout = Matlab_Rail_Control_PC(varargin)   %定义窗口初始化函数
    gui_Singleton = 1;  %启用独占模式
    gui_State = struct('gui_Name',       mfilename, ...     %定义GUI的名称
                   'gui_Singleton',  gui_Singleton, ...     %定义GUI独占
                   'gui_OpeningFcn', @Matlab_Rail_Control_PC_OpeningFcn, ...    %定义窗口启动函数
                   'gui_OutputFcn',  @Matlab_Rail_Control_PC_OutputFcn, ...     %定义窗口输出函数
                   'gui_LayoutFcn',  [] , ...       %定义窗口层
                   'gui_Callback',   []);       %定义回调并设置窗口堆栈
    if nargin && ischar(varargin{1})        %判断输入变量
        gui_State.gui_Callback = str2func(varargin{1});     %指定状态回调
    end     %结束判断变量
    if nargout      %判断输出变量
        [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});   %对应的主函数回调
    else    %继续判断输出变量
        gui_mainfcn(gui_State, varargin{:});    %对应的主函数回调
    end     %结束输出变量判断
    
function Matlab_Rail_Control_PC_OpeningFcn(hObject, eventdata, ...
    handles, varargin)   %窗口初始化函数
    handles.output = hObject;       %设置句柄
    guidata(hObject, handles);      %设置GUI数据
    global x;  %初始化上微机横坐标记录
    global y;  %初始化上微机纵坐标记录
    x = 1;  %初始化横坐标
    y = 1;  %初始化纵坐标
    global net ser;  %初始化接口

function varargout = Matlab_Rail_Control_PC_OutputFcn(hObject,...
    eventdata, handles)   %窗口输出函数
    varargout{1} = handles.output;      %设置输出句柄
    
function FilePath_CreateFcn(hObject, eventdata, handles)    %路径输入框的初始化函数
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,...    
            'defaultUicontrolBackgroundColor'))     %判断设置
        set(hObject,'BackgroundColor','white');     %设置背景色为白色
    end     %结束设置
    
function SMAC_CreateFcn(hObject, eventdata, handles)    %MAC固化输入框的初始化函数
    if ispc && isequal(get(hObject,'BackgroundColor'),...
            get(0,'defaultUicontrolBackgroundColor'))   %判断设置
        set(hObject,'BackgroundColor','white');     %设置背景色为白色
    end     %结束设置

function COM_CreateFcn(hObject, eventdata, handles)     %UART的COM端口下拉选择框
    if ispc && isequal(get(hObject,'BackgroundColor'), ...
            get(0,'defaultUicontrolBackgroundColor'))       %判断设置
        set(hObject,'BackgroundColor','white');     %设置背景色为白色
    end     %结束设置

function ClientIP_CreateFcn(hObject, eventdata, handles)        %允许接入IP地址输入框初始化
    if ispc && isequal(get(hObject,'BackgroundColor'),...
            get(0,'defaultUicontrolBackgroundColor'))       %判断设置
        set(hObject,'BackgroundColor','white');     %设置背景色为白色
    end     %结束设置
    
function SIP_CreateFcn(hObject, eventdata, handles)     %待固化IP输入框初始化
    if ispc && isequal(get(hObject,'BackgroundColor'), ...
            get(0,'defaultUicontrolBackgroundColor'))       %判断设置
        set(hObject,'BackgroundColor','white');     %设置背景色为白色
    end     %结束设置

function SCom_CreateFcn(hObject, eventdata, handles)        %调试指令输入框初始化
    if ispc && isequal(get(hObject,'BackgroundColor'), ...
            get(0,'defaultUicontrolBackgroundColor'))       %判断设置
        set(hObject,'BackgroundColor','white');     %设置背景色为白色
    end     %结束设置

function IP_CreateFcn(hObject, eventdata, handles)      %雕刻机IP地址设置输入框初始化
    if ispc && isequal(get(hObject,'BackgroundColor'),...
            get(0,'defaultUicontrolBackgroundColor'))       %判断设置
        set(hObject,'BackgroundColor','white');     %设置背景色为白色
    end     %结束判断

function SGate_CreateFcn(hObject, eventdata, handles)   %待固化网关设置输入框初始化
    if ispc && isequal(get(hObject,'BackgroundColor'), ...
            get(0,'defaultUicontrolBackgroundColor'))       %判断设置
        set(hObject,'BackgroundColor','white');     %设置背景色为白色
    end     %结束设置

function PaintingSchedule_CreateFcn(hObject, eventdata, handles)    %打印进度框初始化
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,...
            'defaultUicontrolBackgroundColor'))     %判断设置
        set(hObject,'BackgroundColor','white');     %设置背景色为白色
    end     %结束设置

function PaintingSchedule_Callback(hObject, eventdata, handles)     %打印进度回调
    %此处留空，防止回调错误
    
function ClientIP_Callback(hObject, eventdata, handles)     %允许接入IP地址输入框回调
    %此处留空，防止回调错误

function FilePath_Callback(hObject, eventdata, handles)     %单击路径输入条的回调
    %此处留空，防止单击输入条产生调用错误
        
function Best_Callback(hObject, eventdata, handles)     %勾选“最棒”复选框的回调
    %此处留空，防止回调错误
    
function Cutest_Callback(hObject, eventdata, handles)   %勾选“最萌”复选框的回调
    %此处留空，防止回调错误

function Cleverest_Callback(hObject, eventdata, handles)    %勾选“最机智”复选框的回调
    %此处留空，防止回调错误

function SelectFile_Callback(hObject, eventdata, handles)   %“选择文件”按钮的回调函数
    [filename,filepath]=uigetfile({'*.bmp;*.jpg;*.png;*.tif;*.gif',...
        '我们支持的所有格式';'*.*','你认为我们能支持但我们并不确定的格式'},...
        '请选择要打印的图片文件',...
        'MultiSelect','off');   %文件选择框设置
    if ~filename    %判断文件名非空
        filename=' ';   %若文件未被选取，则清空路径输入框
    end     %结束文件名判断
    set(handles.FilePath,'String',[filepath,filename]);     %在路径输入框中显示文件绝对路径

function BothValueMethod_Callback(hObject, eventdata, handles)      %“灰度连续”选项单选框的回调
    set(handles.BothValueMethod,'value',1)      %设置回调按钮为选中状态
    set(handles.GrayMethod,'value',0)       %设置与此按钮互斥的“灰度扫描”单选框为未选中状态

function GrayMethod_Callback(hObject, eventdata, handles)       %“灰度扫描”单选框的回调
    set(handles.BothValueMethod,'value',0);     %设置与此按钮互斥的“灰度连续”单选框为未选中状态
    set(handles.GrayMethod,'value',1);      %设置回调按钮为选中状态

function Ethernet_Callback(hObject, eventdata, handles)     %“Ethernet”方式单选框回调
    set(handles.Ethernet,'value',1);        %设置此回调按钮为选中状态
    set(handles.UART,'value',0);        %设置互斥的“UART”单选按钮为未选中状态

function UART_Callback(hObject, eventdata, handles)     %“UART”方式单选按钮回调
    set(handles.Ethernet,'value',0);        %设置互斥的“Ethernet”单选按钮为未选中状态
    set(handles.UART,'value',1);        %设置此按钮为选中状态

function IP_Callback(hObject, eventdata, handles)   %设置IP输入框回调
    %此处留空，防止回调错误

function COM_Callback(hObject, eventdata, handles)  %设置COM端口下拉选择框回调
    %此处留空，防止回调错误

function SIP_Callback(hObject, eventdata, handles)  %待固化IP地址输入框回调
    %此处留空，防止回调错误

function SAdd_Callback(hObject, eventdata, handles) %待固化MAC地址输入框回调
    global net ser x y;  %引用全局变量
    temp = get(handles.PaintingSchedule,'string');  %寄存进度条
    set(handles.PaintingSchedule,'string','刷写中..');  %设置进度条提示
    con = Config(hObject,eventdata,handles);    %设置端口并取得端口设置情况
    if con     %判断设置是否完成
        sip = (str2num(char(strsplit(get(handles.SIP,'string'),'.'))))';    %获取待固化IP并转换为数组
        sgate = (str2num(char(strsplit(get(handles.SGate,'string'),...
            '.'))))';       %获取待固化网关地址并转换为数组
        smac = (str2num(char(strsplit(get(handles.SMAC,'string'),':'))))';  %获取待固化MAC并转换为数组
        if get(handles.DHCPEnable,'value')  %检测DHCP启用情况
            dhcp = 0;   %准备刷写参数
        else   %检测DHCP未启用情况
            dhcp = 1;   %准备刷写参数
        end     %结束DHCP配置
        fopen(net);     %打开以太网端口
        fwrite(net,['C',dhcp,sip,sgate,smac,0]); %以协议规定形式对下位机编程
        fclose(net);    %关闭以太网端口，防止误码
        set(handles.PaintingSchedule,'string',temp); %恢复进度条
        errordlg('刷机完成！','好消息！');   %弹出提示
    else     %配置失败
        errordlg('配置失败！','未知错误');
    end

function SCom_Callback(hObject, eventdata, handles) %调试指令输入框回调
    %此处留空，防止回调错误

function Send_Callback(hObject, eventdata, handles) %发送调试指令按钮回调
    global net ser x y;
    con = Config(hObject,eventdata,handles);    %设置端口并取得端口设置情况
    if con     %判断设置是否完成
        if get(handles.Ethernet,'value')    %检测以太网方式
            cmd = (hex2dec(char(strsplit(get(handles.SCom,...
                'string'),'x'))))';     %获取指令转换到指定格式
            cmd = cmd(2);   %删除前导零
            fopen(net);     %打开以太网端口
            fwrite(net,['G',cmd]);  %以协议规定传输指令
            fclose(net);    %关闭以太网端口，防止误码
        end     %结束以太网传送
        if get(handles.UART,'value')    %检测UART方式
            cmd = (hex2dec(char(strsplit(get(handles.SCom,...
                'string'),'x'))))';     %获取指令转换到指定格式
            cmd = cmd(2);   %删除前导零
            fwrite(ser,cmd);    %串口传输指令
        end     %结束UART传输
    end     %判断结束
        
function SGate_Callback(hObject, eventdata, handles)    %待固化网关输入框回调
    %此处留空，防止回调错误

function DHCPEnable_Callback(hObject, eventdata, handles)   %DHCP使能复选框回调
    if get(handles.DHCPEnable,'value')  %判断复选框选中状态
        set(handles.SIP,'enable','off');    %关闭待固化IP输入框
        set(handles.SGate,'enable','off');     %关闭待固化网关输入框
    else    %判断复选框未选中
        set(handles.SIP,'enable','on');     %使能待固化IP输入框
        set(handles.SGate,'enable','on');   %使能待固化网关输入框
    end     %结束设置

function SMAC_Callback(hObject, eventdata, handles)     %待固化MAC输入框回调
     %此处留空，方式回调错误

function PausePainting_Callback(hObject, eventdata, handles)    %暂停绘图按钮回调
    %此处留空，防止回调错误

function StopPainting_Callback(hObject, eventdata, handles)     %停止绘图按钮回调
%此处留空，防止回调错误

function TrueSelf_Callback(hObject, eventdata, handles)     %自信复选框回调
    if get(handles.TrueSelf,'value')    %判断复选框选中状态
        set(handles.text14,'enable','on');
        set(handles.text23,'enable','on');
        set(handles.text15,'enable','on');
        set(handles.text22,'enable','on');
        set(handles.text24,'enable','on');
        set(handles.text17,'enable','on');
        set(handles.text18,'enable','on');
        set(handles.text20,'enable','on');
        set(handles.DHCPEnable,'enable','on');
        set(handles.SMAC,'enable','on');
        set(handles.SIP,'enable','on');
        set(handles.SGate,'enable','on');
        set(handles.SCom,'enable','on');
        set(handles.SAdd,'enable','on');
        set(handles.Send,'enable','on');    %使能专家模式所有选项
    else    %判断复选框未选中
        set(handles.text14,'enable','off');
        set(handles.text23,'enable','off');
        set(handles.text15,'enable','off');
        set(handles.text22,'enable','off');
        set(handles.text24,'enable','off');
        set(handles.text17,'enable','off');
        set(handles.text18,'enable','off');
        set(handles.text20,'enable','off');
        set(handles.DHCPEnable,'enable','off');
        set(handles.SMAC,'enable','off');
        set(handles.SIP,'enable','off');
        set(handles.SGate,'enable','off');
        set(handles.SCom,'enable','off');
        set(handles.SAdd,'enable','off');
        set(handles.Send,'enable','off');   %关闭专家模式所有选项
    end     %结束判断

function TestPainting_Callback(hObject, eventdata, handles)     %绘制测试页按钮回调
    global net ser x y;  %引用全局变量
    msg=[];     %准备可能的输出变量空间
    msf=0;      %判断标记
    if get(handles.Best,'value')==0     %检测“最棒”复选框选中状态
        msg=[msg,'不棒'];     %若没有选中，准备错误信息
        msf=1;      %标记错误
    end     %结束判断
    if get(handles.Cutest,'value')==0   %判断“最萌”复选框选中状态
        msg=[msg,'不萌'];     %若没有选中，准备错误信息
        msf=1;      %标记错误
    end     %结束判断
    if get(handles.Cleverest,'value')==0    %判断“最机智”复选框选中状态
        msg=[msg,'不机智'];    %若没有选中，准备错误信息
        msf=1;      %标记错误
    end     %结束判断
    if msf   %检测错误标记
        msgdlg=errordlg(['你认为我们',msg,...
            '！我们不要给你绘制美美哒测试页！'],'评价错误');    %输出错误信息
        return     %跳出此函数
    end     %结束错误判断
    con = Config(hObject,eventdata,handles);    %设置端口并取得端口设置情况
    if con     %判断设置是否完成
        PaintTestPage(hObject,eventdata,handles);   %若设置完成，绘制测试页
    end     %结束判断

function StartPainting_Callback(hObject, eventdata, handles)    %“开始绘图”按钮回调
    global net ser x y;  %引用全局变量
    msg=[];     %准备错误信息空间
    msf=0;      %准备错误标记
    if get(handles.Best,'value')==0     %判断“最棒”复选框选中状态
        msg=[msg,'不棒'];     %准备错误信息
        msf=1;      %标记错误
    end     %结束判断
    if get(handles.Cutest,'value')==0   %判断“最萌”复选框选中状态
        msg=[msg,'不萌'];     %准备错误信息
        msf=1;      %标记错误
    end     %结束判断
    if get(handles.Cleverest,'value')==0    %判断“最机智”复选框选中状态
        msg=[msg,'不机智'];    %准备错误信息
        msf=1;      %标记错误
    end     %结束判断
    if msf   %判断错误标记
        msgdlg=errordlg(['你认为我们',msg,...
            '！我们不要给你绘图！'],'评价错误');  %输出错误信息
        return  %跳出此函数
    end     %结束判断
    con = Config(hObject,eventdata,handles);  %设置端口并返回设置信息
    if con
        if get(handles.BothValueMethod,'value')
            Paint(hObject,eventdata,handles,'二分');
        end
        if get(handles.GrayMethod,'value')
            Paint(hObject,eventdata,handles,'单向');
        end
    end

function con = Config(hObject,eventdata,handles)    %端口设置函数
    global net ser x y;  %引用全局变量
    temp=get(handles.PaintingSchedule,'string');    %寄存状态窗口状态
    set(handles.PaintingSchedule,'string','配置中..');     %输出配置中提示
    pause(1);   %等待输出完成
    con=0;      %成功标记清空
    if get(handles.Ethernet,'value')    %检测“Ethernet”方式单选框是否选中
        try     %尝试设置以太网端口
            net=tcpip(get(handles.IP,'String'),80,'networkrole',...
                'client');      %读取以太网端口设置并尝试链接绘图仪
            fopen(net);     %打开网络端口
            fclose(net);    %关闭网络端口备用
            con = 1;    %记录成功
        catch   %尝试失败时
            msgdlg=errordlg('IP地址格式填写错误或连接存在故障，请检查后重试。',...
                '网络错误');    %输出错误信息
            set(handles.PaintingSchedule,'string',temp);    %还原绘图进度
            return  %函数返回
        end     %结束尝试
    end     %结束以太网设置
    if get(handles.UART,'value')    %检测“UART”方式是否被选中
        try     %尝试设置串口
            ser=serial(get(handles.COM,'value'));   %设置串口号
            set(ser,'baudrate',19200,'StopBits',1,'Parity','none',...
                'DataBits',8,'InputBufferSize',255);    %设置串口工作状态
            fopen(ser);     %尝试打开串口
            con = 1;    %记录成功
        catch   %尝试失败时
            msgdlg=errordlg('串口不存在或被占用，请检查后重试。',...
                '串口错误');    %输出错误信息
            set(handles.PaintingSchedule,'string',temp);    %还原绘图进度
            return  %函数返回
        end     %结束尝试
    end     %结束串口设置
    if ~con     %检测到所有方式均未被选中
        msgdlg=errordlg('你没有选择通信模式，请检查后重试。','通信模式缺失');  %输出提示
        set(handles.PaintingSchedule,'string',temp);    %还原绘图进度
        return  %函数返回
    end     %结束检测
    set(handles.PaintingSchedule,'string',temp);    %还原绘图进度
    return  %函数返回
    
function PaintTestPage(hObject,eventdata,handles)   %测试页绘制函数(不使用复用函数库)
    global net ser x y;  %引用全局变量
    pause(2);   %等待2秒
    set(handles.FilePath,'string','test.bmp');
    StartPainting_Callback(hObject, eventdata, handles);
    
function [img,half,mx,my] = ImageProcess(hObject,eventdata,handles)    %图像处理函数
    global gray;
    set(handles.PaintingSchedule,'String','处理中..');     %输出进度条提示
    img = imread(get(handles.FilePath,'String'));   %读取图像文件
    try
        img = rgb2gray(img);    %灰度转换
    end
    [iy,ix] = size(img);    %取得图像尺寸
    if ix>400||iy>500    
        bx = 400 / ix;      %计算可能的缩放比
        by = 500 / iy;     %计算可能的缩放比
        if bx < by  %判断缩放方向
            img = imresize(img,[iy * bx,400]);     %尺寸调整
        else    %判断缩放方向
            img = imresize(img,[900,ix * by]);     %尺寸调整
        end     %结束缩放
    end
    tmp=size(img);
    img=[255*ones(tmp(1,1),1),img];
    [my,mx]=size(img);
    half=floor(mx/2);
    if get(handles.BothValueMethod,'value')
        img=[img(:,1:half),255*ones(tmp(1,1),1),img(:,half+1:end)];
    end
    [my,mx]=size(img);
    img=img';
    img=255-img;
    return  %函数返回图像

function Paint(hObject,eventdata,handles,mode)
    global net ser x y bar z nz;  %引用全局变量
    [img,half,mx,my] = ImageProcess(hObject,eventdata,handles);  %对图像进行处理
    z=sum(size(img(img>140)))-1;
    nz=z;
    bar=waitbar(0,'绘图进行中...','name','正在绘图');
    tic;
    ray();
    ray();
    ray();
    ray();
    ray();
    if strcmp(mode,'双向')
        for j=1:1:my
            if rem(j,2)
                a=1;
                b=mx;
                dx=1;
            else
                a=mx;
                b=1;
                dx=-1;
            end
            for i=a:dx:b
                if img(i,j)>140
                    ray();
                end
                if rem(j,2)
                    xstep(1);
                else
                    xstep(0);
                end
            end
            ystep(1);
        end
    end
    if strcmp(mode,'单向')
        for j=1:my
            for i = 1:mx
                if img(i,j)>=140
                    ray();
                end
                xstep(1);
            end
            for i=1:mx
                cxstep(0);
            end
            ystep(1);
        end
    end
    if strcmp(mode,'加窗')
        x=1;
        for j=1:1:my
            row=img(:,j)';
            fprintl(row)
            ystep(1);
        end
    end
    if strcmp(mode,'二分')
        x=1;
        y=1;
        iml=img(1:half,:);
        imr=img(half+1:mx,:);
        for j=1:1:my
            row=iml(:,j)';
            fprintl(row);
        end
        go(half-1,1);
        xstep(1);
        ystep(0);
        ystep(0);
        ystep(0);
        ystep(0);
        ystep(0);
        ystep(0);
        ystep(0);
        ystep(1);
        x=1;
        for j=1:1:my
            row=imr(:,j)';
            fprintl(row);
        end
    end
    pause(1);
    fopen(net);
    fwrite(net,['G',hex2dec('04')]);
    fclose(net);
    t=toc;
    close(bar);
    h=floor(t/60/60);
    min=floor(t/60)-h*60;
    sec=floor(t)-h*60*60-min*60;
    msgbox(['绘图完成！耗时：',...
        num2str(floor(h)),'h',...
        num2str(floor(min)),'min',...
        num2str(floor(sec)),'s;'],'绘图完成');

function fprintl(row)
    global x y net;
    fx=sum(size(row))-1;
    fa=0;
    for fi=1:1:fx
        if row(1,fi)>=140
            if ~fa
                fa=fi;
            end
            fb=fi;
        end
    end
    if fa
        go(fa-1,y);
        xstep(1);
        xstep(1);
        for fi=fa:fb
            if row(1,fi)>=140
                ray();
            end
            xstep(1);
        end
        for fi=fb:fa
            if row(1,fi)>=140
                ray();
            end
            xstep(0);
        end
        ystep(1);
    end

function go(ax,ay)
    global x y net;
    if abs(ax-y)
        for i=0:(ax-x)/abs(ax-x):ax-x
            if ax>x
                cxstep(1);
            else
                cxstep(0);
            end
        end
    end
    if abs(ay-y)
        for i=0:(ay-y)/abs(ay-y):(ay-y)
            if ay>y
                ystep(1);
            else
                ystep(0);
            end
        end
    end

function xstep(frd)
    global x y net;
    if frd
        fopen(net);
        fwrite(net,['G',hex2dec('89')]);
        fclose(net);
        x=x+1;
    else
        fopen(net);
        fwrite(net,['G',hex2dec('49')]);
        fclose(net);
        x=x-1;
    end
    pause(20/1000);

function cxstep(frd)
    global x y net;
    if frd
        fopen(net);
        fwrite(net,['G',hex2dec('81')]);
        fclose(net);
        x=x+1;
    else
        fopen(net);
        fwrite(net,['G',hex2dec('41')]);
        fclose(net);
        x=x-1;
    end
    pause(20/1000);

function ystep(frd)
    global x y net;
    for yi=1:2
        if frd
            fopen(net);
            fwrite(net,['G',hex2dec('21')]);
            fclose(net);
            y=y+1;
        else
            fopen(net);
            fwrite(net,['G',hex2dec('11')]);
            fclose(net);
            y=y-1;
        end
        pause(85/1000);
    end

function eystep(frd)
    global x y net;
    for yi=1:2
        if frd
            fopen(net);
            fwrite(net,['G',hex2dec('29')]);
            fclose(net);
            y=y+1;
        else
            fopen(net);
            fwrite(net,['G',hex2dec('19')]);
            fclose(net);
            y=y-1;
        end
        pause(85/1000);
    end

function ray()
    global x y net bar z nz;
    nz=nz-1;
    fopen(net);
    fwrite(net,['G',hex2dec('09')]);
    fclose(net);
    pause(200/1000);
    fopen(net);
    fwrite(net,['G',hex2dec('01')]);
    fclose(net);
    waitbar(1-nz/z,bar,'绘图进行中...');