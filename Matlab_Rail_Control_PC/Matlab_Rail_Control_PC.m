function varargout = Matlab_Rail_Control_PC(varargin)   %���崰�ڳ�ʼ������
    gui_Singleton = 1;  %���ö�ռģʽ
    gui_State = struct('gui_Name',       mfilename, ...     %����GUI������
                   'gui_Singleton',  gui_Singleton, ...     %����GUI��ռ
                   'gui_OpeningFcn', @Matlab_Rail_Control_PC_OpeningFcn, ...    %���崰����������
                   'gui_OutputFcn',  @Matlab_Rail_Control_PC_OutputFcn, ...     %���崰���������
                   'gui_LayoutFcn',  [] , ...       %���崰�ڲ�
                   'gui_Callback',   []);       %����ص������ô��ڶ�ջ
    if nargin && ischar(varargin{1})        %�ж��������
        gui_State.gui_Callback = str2func(varargin{1});     %ָ��״̬�ص�
    end     %�����жϱ���
    if nargout      %�ж��������
        [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});   %��Ӧ���������ص�
    else    %�����ж��������
        gui_mainfcn(gui_State, varargin{:});    %��Ӧ���������ص�
    end     %������������ж�
    
function Matlab_Rail_Control_PC_OpeningFcn(hObject, eventdata, ...
    handles, varargin)   %���ڳ�ʼ������
    handles.output = hObject;       %���þ��
    guidata(hObject, handles);      %����GUI����
    global x;  %��ʼ����΢���������¼
    global y;  %��ʼ����΢���������¼
    x = 1;  %��ʼ��������
    y = 1;  %��ʼ��������
    global net ser;  %��ʼ���ӿ�

function varargout = Matlab_Rail_Control_PC_OutputFcn(hObject,...
    eventdata, handles)   %�����������
    varargout{1} = handles.output;      %����������
    
function FilePath_CreateFcn(hObject, eventdata, handles)    %·�������ĳ�ʼ������
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,...    
            'defaultUicontrolBackgroundColor'))     %�ж�����
        set(hObject,'BackgroundColor','white');     %���ñ���ɫΪ��ɫ
    end     %��������
    
function SMAC_CreateFcn(hObject, eventdata, handles)    %MAC�̻������ĳ�ʼ������
    if ispc && isequal(get(hObject,'BackgroundColor'),...
            get(0,'defaultUicontrolBackgroundColor'))   %�ж�����
        set(hObject,'BackgroundColor','white');     %���ñ���ɫΪ��ɫ
    end     %��������

function COM_CreateFcn(hObject, eventdata, handles)     %UART��COM�˿�����ѡ���
    if ispc && isequal(get(hObject,'BackgroundColor'), ...
            get(0,'defaultUicontrolBackgroundColor'))       %�ж�����
        set(hObject,'BackgroundColor','white');     %���ñ���ɫΪ��ɫ
    end     %��������

function ClientIP_CreateFcn(hObject, eventdata, handles)        %�������IP��ַ������ʼ��
    if ispc && isequal(get(hObject,'BackgroundColor'),...
            get(0,'defaultUicontrolBackgroundColor'))       %�ж�����
        set(hObject,'BackgroundColor','white');     %���ñ���ɫΪ��ɫ
    end     %��������
    
function SIP_CreateFcn(hObject, eventdata, handles)     %���̻�IP������ʼ��
    if ispc && isequal(get(hObject,'BackgroundColor'), ...
            get(0,'defaultUicontrolBackgroundColor'))       %�ж�����
        set(hObject,'BackgroundColor','white');     %���ñ���ɫΪ��ɫ
    end     %��������

function SCom_CreateFcn(hObject, eventdata, handles)        %����ָ��������ʼ��
    if ispc && isequal(get(hObject,'BackgroundColor'), ...
            get(0,'defaultUicontrolBackgroundColor'))       %�ж�����
        set(hObject,'BackgroundColor','white');     %���ñ���ɫΪ��ɫ
    end     %��������

function IP_CreateFcn(hObject, eventdata, handles)      %��̻�IP��ַ����������ʼ��
    if ispc && isequal(get(hObject,'BackgroundColor'),...
            get(0,'defaultUicontrolBackgroundColor'))       %�ж�����
        set(hObject,'BackgroundColor','white');     %���ñ���ɫΪ��ɫ
    end     %�����ж�

function SGate_CreateFcn(hObject, eventdata, handles)   %���̻���������������ʼ��
    if ispc && isequal(get(hObject,'BackgroundColor'), ...
            get(0,'defaultUicontrolBackgroundColor'))       %�ж�����
        set(hObject,'BackgroundColor','white');     %���ñ���ɫΪ��ɫ
    end     %��������

function PaintingSchedule_CreateFcn(hObject, eventdata, handles)    %��ӡ���ȿ��ʼ��
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,...
            'defaultUicontrolBackgroundColor'))     %�ж�����
        set(hObject,'BackgroundColor','white');     %���ñ���ɫΪ��ɫ
    end     %��������

function PaintingSchedule_Callback(hObject, eventdata, handles)     %��ӡ���Ȼص�
    %�˴����գ���ֹ�ص�����
    
function ClientIP_Callback(hObject, eventdata, handles)     %�������IP��ַ�����ص�
    %�˴����գ���ֹ�ص�����

function FilePath_Callback(hObject, eventdata, handles)     %����·���������Ļص�
    %�˴����գ���ֹ�����������������ô���
        
function Best_Callback(hObject, eventdata, handles)     %��ѡ���������ѡ��Ļص�
    %�˴����գ���ֹ�ص�����
    
function Cutest_Callback(hObject, eventdata, handles)   %��ѡ�����ȡ���ѡ��Ļص�
    %�˴����գ���ֹ�ص�����

function Cleverest_Callback(hObject, eventdata, handles)    %��ѡ������ǡ���ѡ��Ļص�
    %�˴����գ���ֹ�ص�����

function SelectFile_Callback(hObject, eventdata, handles)   %��ѡ���ļ�����ť�Ļص�����
    [filename,filepath]=uigetfile({'*.bmp;*.jpg;*.png;*.tif;*.gif',...
        '����֧�ֵ����и�ʽ';'*.*','����Ϊ������֧�ֵ����ǲ���ȷ���ĸ�ʽ'},...
        '��ѡ��Ҫ��ӡ��ͼƬ�ļ�',...
        'MultiSelect','off');   %�ļ�ѡ�������
    if ~filename    %�ж��ļ����ǿ�
        filename=' ';   %���ļ�δ��ѡȡ�������·�������
    end     %�����ļ����ж�
    set(handles.FilePath,'String',[filepath,filename]);     %��·�����������ʾ�ļ�����·��

function BothValueMethod_Callback(hObject, eventdata, handles)      %���Ҷ�������ѡ�ѡ��Ļص�
    set(handles.BothValueMethod,'value',1)      %���ûص���ťΪѡ��״̬
    set(handles.GrayMethod,'value',0)       %������˰�ť����ġ��Ҷ�ɨ�衱��ѡ��Ϊδѡ��״̬

function GrayMethod_Callback(hObject, eventdata, handles)       %���Ҷ�ɨ�衱��ѡ��Ļص�
    set(handles.BothValueMethod,'value',0);     %������˰�ť����ġ��Ҷ���������ѡ��Ϊδѡ��״̬
    set(handles.GrayMethod,'value',1);      %���ûص���ťΪѡ��״̬

function Ethernet_Callback(hObject, eventdata, handles)     %��Ethernet����ʽ��ѡ��ص�
    set(handles.Ethernet,'value',1);        %���ô˻ص���ťΪѡ��״̬
    set(handles.UART,'value',0);        %���û���ġ�UART����ѡ��ťΪδѡ��״̬

function UART_Callback(hObject, eventdata, handles)     %��UART����ʽ��ѡ��ť�ص�
    set(handles.Ethernet,'value',0);        %���û���ġ�Ethernet����ѡ��ťΪδѡ��״̬
    set(handles.UART,'value',1);        %���ô˰�ťΪѡ��״̬

function IP_Callback(hObject, eventdata, handles)   %����IP�����ص�
    %�˴����գ���ֹ�ص�����

function COM_Callback(hObject, eventdata, handles)  %����COM�˿�����ѡ���ص�
    %�˴����գ���ֹ�ص�����

function SIP_Callback(hObject, eventdata, handles)  %���̻�IP��ַ�����ص�
    %�˴����գ���ֹ�ص�����

function SAdd_Callback(hObject, eventdata, handles) %���̻�MAC��ַ�����ص�
    global net ser x y;  %����ȫ�ֱ���
    temp = get(handles.PaintingSchedule,'string');  %�Ĵ������
    set(handles.PaintingSchedule,'string','ˢд��..');  %���ý�������ʾ
    con = Config(hObject,eventdata,handles);    %���ö˿ڲ�ȡ�ö˿��������
    if con     %�ж������Ƿ����
        sip = (str2num(char(strsplit(get(handles.SIP,'string'),'.'))))';    %��ȡ���̻�IP��ת��Ϊ����
        sgate = (str2num(char(strsplit(get(handles.SGate,'string'),...
            '.'))))';       %��ȡ���̻����ص�ַ��ת��Ϊ����
        smac = (str2num(char(strsplit(get(handles.SMAC,'string'),':'))))';  %��ȡ���̻�MAC��ת��Ϊ����
        if get(handles.DHCPEnable,'value')  %���DHCP�������
            dhcp = 0;   %׼��ˢд����
        else   %���DHCPδ�������
            dhcp = 1;   %׼��ˢд����
        end     %����DHCP����
        fopen(net);     %����̫���˿�
        fwrite(net,['C',dhcp,sip,sgate,smac,0]); %��Э��涨��ʽ����λ�����
        fclose(net);    %�ر���̫���˿ڣ���ֹ����
        set(handles.PaintingSchedule,'string',temp); %�ָ�������
        errordlg('ˢ����ɣ�','����Ϣ��');   %������ʾ
    else     %����ʧ��
        errordlg('����ʧ�ܣ�','δ֪����');
    end

function SCom_Callback(hObject, eventdata, handles) %����ָ�������ص�
    %�˴����գ���ֹ�ص�����

function Send_Callback(hObject, eventdata, handles) %���͵���ָ�ť�ص�
    global net ser x y;
    con = Config(hObject,eventdata,handles);    %���ö˿ڲ�ȡ�ö˿��������
    if con     %�ж������Ƿ����
        if get(handles.Ethernet,'value')    %�����̫����ʽ
            cmd = (hex2dec(char(strsplit(get(handles.SCom,...
                'string'),'x'))))';     %��ȡָ��ת����ָ����ʽ
            cmd = cmd(2);   %ɾ��ǰ����
            fopen(net);     %����̫���˿�
            fwrite(net,['G',cmd]);  %��Э��涨����ָ��
            fclose(net);    %�ر���̫���˿ڣ���ֹ����
        end     %������̫������
        if get(handles.UART,'value')    %���UART��ʽ
            cmd = (hex2dec(char(strsplit(get(handles.SCom,...
                'string'),'x'))))';     %��ȡָ��ת����ָ����ʽ
            cmd = cmd(2);   %ɾ��ǰ����
            fwrite(ser,cmd);    %���ڴ���ָ��
        end     %����UART����
    end     %�жϽ���
        
function SGate_Callback(hObject, eventdata, handles)    %���̻����������ص�
    %�˴����գ���ֹ�ص�����

function DHCPEnable_Callback(hObject, eventdata, handles)   %DHCPʹ�ܸ�ѡ��ص�
    if get(handles.DHCPEnable,'value')  %�жϸ�ѡ��ѡ��״̬
        set(handles.SIP,'enable','off');    %�رմ��̻�IP�����
        set(handles.SGate,'enable','off');     %�رմ��̻����������
    else    %�жϸ�ѡ��δѡ��
        set(handles.SIP,'enable','on');     %ʹ�ܴ��̻�IP�����
        set(handles.SGate,'enable','on');   %ʹ�ܴ��̻����������
    end     %��������

function SMAC_Callback(hObject, eventdata, handles)     %���̻�MAC�����ص�
     %�˴����գ���ʽ�ص�����

function PausePainting_Callback(hObject, eventdata, handles)    %��ͣ��ͼ��ť�ص�
    %�˴����գ���ֹ�ص�����

function StopPainting_Callback(hObject, eventdata, handles)     %ֹͣ��ͼ��ť�ص�
%�˴����գ���ֹ�ص�����

function TrueSelf_Callback(hObject, eventdata, handles)     %���Ÿ�ѡ��ص�
    if get(handles.TrueSelf,'value')    %�жϸ�ѡ��ѡ��״̬
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
        set(handles.Send,'enable','on');    %ʹ��ר��ģʽ����ѡ��
    else    %�жϸ�ѡ��δѡ��
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
        set(handles.Send,'enable','off');   %�ر�ר��ģʽ����ѡ��
    end     %�����ж�

function TestPainting_Callback(hObject, eventdata, handles)     %���Ʋ���ҳ��ť�ص�
    global net ser x y;  %����ȫ�ֱ���
    msg=[];     %׼�����ܵ���������ռ�
    msf=0;      %�жϱ��
    if get(handles.Best,'value')==0     %��⡰�������ѡ��ѡ��״̬
        msg=[msg,'����'];     %��û��ѡ�У�׼��������Ϣ
        msf=1;      %��Ǵ���
    end     %�����ж�
    if get(handles.Cutest,'value')==0   %�жϡ����ȡ���ѡ��ѡ��״̬
        msg=[msg,'����'];     %��û��ѡ�У�׼��������Ϣ
        msf=1;      %��Ǵ���
    end     %�����ж�
    if get(handles.Cleverest,'value')==0    %�жϡ�����ǡ���ѡ��ѡ��״̬
        msg=[msg,'������'];    %��û��ѡ�У�׼��������Ϣ
        msf=1;      %��Ǵ���
    end     %�����ж�
    if msf   %��������
        msgdlg=errordlg(['����Ϊ����',msg,...
            '�����ǲ�Ҫ������������ղ���ҳ��'],'���۴���');    %���������Ϣ
        return     %�����˺���
    end     %���������ж�
    con = Config(hObject,eventdata,handles);    %���ö˿ڲ�ȡ�ö˿��������
    if con     %�ж������Ƿ����
        PaintTestPage(hObject,eventdata,handles);   %��������ɣ����Ʋ���ҳ
    end     %�����ж�

function StartPainting_Callback(hObject, eventdata, handles)    %����ʼ��ͼ����ť�ص�
    global net ser x y;  %����ȫ�ֱ���
    msg=[];     %׼��������Ϣ�ռ�
    msf=0;      %׼��������
    if get(handles.Best,'value')==0     %�жϡ��������ѡ��ѡ��״̬
        msg=[msg,'����'];     %׼��������Ϣ
        msf=1;      %��Ǵ���
    end     %�����ж�
    if get(handles.Cutest,'value')==0   %�жϡ����ȡ���ѡ��ѡ��״̬
        msg=[msg,'����'];     %׼��������Ϣ
        msf=1;      %��Ǵ���
    end     %�����ж�
    if get(handles.Cleverest,'value')==0    %�жϡ�����ǡ���ѡ��ѡ��״̬
        msg=[msg,'������'];    %׼��������Ϣ
        msf=1;      %��Ǵ���
    end     %�����ж�
    if msf   %�жϴ�����
        msgdlg=errordlg(['����Ϊ����',msg,...
            '�����ǲ�Ҫ�����ͼ��'],'���۴���');  %���������Ϣ
        return  %�����˺���
    end     %�����ж�
    con = Config(hObject,eventdata,handles);  %���ö˿ڲ�����������Ϣ
    if con
        if get(handles.BothValueMethod,'value')
            Paint(hObject,eventdata,handles,'����');
        end
        if get(handles.GrayMethod,'value')
            Paint(hObject,eventdata,handles,'����');
        end
    end

function con = Config(hObject,eventdata,handles)    %�˿����ú���
    global net ser x y;  %����ȫ�ֱ���
    temp=get(handles.PaintingSchedule,'string');    %�Ĵ�״̬����״̬
    set(handles.PaintingSchedule,'string','������..');     %�����������ʾ
    pause(1);   %�ȴ�������
    con=0;      %�ɹ�������
    if get(handles.Ethernet,'value')    %��⡰Ethernet����ʽ��ѡ���Ƿ�ѡ��
        try     %����������̫���˿�
            net=tcpip(get(handles.IP,'String'),80,'networkrole',...
                'client');      %��ȡ��̫���˿����ò��������ӻ�ͼ��
            fopen(net);     %������˿�
            fclose(net);    %�ر�����˿ڱ���
            con = 1;    %��¼�ɹ�
        catch   %����ʧ��ʱ
            msgdlg=errordlg('IP��ַ��ʽ��д��������Ӵ��ڹ��ϣ���������ԡ�',...
                '�������');    %���������Ϣ
            set(handles.PaintingSchedule,'string',temp);    %��ԭ��ͼ����
            return  %��������
        end     %��������
    end     %������̫������
    if get(handles.UART,'value')    %��⡰UART����ʽ�Ƿ�ѡ��
        try     %�������ô���
            ser=serial(get(handles.COM,'value'));   %���ô��ں�
            set(ser,'baudrate',19200,'StopBits',1,'Parity','none',...
                'DataBits',8,'InputBufferSize',255);    %���ô��ڹ���״̬
            fopen(ser);     %���Դ򿪴���
            con = 1;    %��¼�ɹ�
        catch   %����ʧ��ʱ
            msgdlg=errordlg('���ڲ����ڻ�ռ�ã���������ԡ�',...
                '���ڴ���');    %���������Ϣ
            set(handles.PaintingSchedule,'string',temp);    %��ԭ��ͼ����
            return  %��������
        end     %��������
    end     %������������
    if ~con     %��⵽���з�ʽ��δ��ѡ��
        msgdlg=errordlg('��û��ѡ��ͨ��ģʽ����������ԡ�','ͨ��ģʽȱʧ');  %�����ʾ
        set(handles.PaintingSchedule,'string',temp);    %��ԭ��ͼ����
        return  %��������
    end     %�������
    set(handles.PaintingSchedule,'string',temp);    %��ԭ��ͼ����
    return  %��������
    
function PaintTestPage(hObject,eventdata,handles)   %����ҳ���ƺ���(��ʹ�ø��ú�����)
    global net ser x y;  %����ȫ�ֱ���
    pause(2);   %�ȴ�2��
    set(handles.FilePath,'string','test.bmp');
    StartPainting_Callback(hObject, eventdata, handles);
    
function [img,half,mx,my] = ImageProcess(hObject,eventdata,handles)    %ͼ������
    global gray;
    set(handles.PaintingSchedule,'String','������..');     %�����������ʾ
    img = imread(get(handles.FilePath,'String'));   %��ȡͼ���ļ�
    try
        img = rgb2gray(img);    %�Ҷ�ת��
    end
    [iy,ix] = size(img);    %ȡ��ͼ��ߴ�
    if ix>400||iy>500    
        bx = 400 / ix;      %������ܵ����ű�
        by = 500 / iy;     %������ܵ����ű�
        if bx < by  %�ж����ŷ���
            img = imresize(img,[iy * bx,400]);     %�ߴ����
        else    %�ж����ŷ���
            img = imresize(img,[900,ix * by]);     %�ߴ����
        end     %��������
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
    return  %��������ͼ��

function Paint(hObject,eventdata,handles,mode)
    global net ser x y bar z nz;  %����ȫ�ֱ���
    [img,half,mx,my] = ImageProcess(hObject,eventdata,handles);  %��ͼ����д���
    z=sum(size(img(img>140)))-1;
    nz=z;
    bar=waitbar(0,'��ͼ������...','name','���ڻ�ͼ');
    tic;
    ray();
    ray();
    ray();
    ray();
    ray();
    if strcmp(mode,'˫��')
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
    if strcmp(mode,'����')
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
    if strcmp(mode,'�Ӵ�')
        x=1;
        for j=1:1:my
            row=img(:,j)';
            fprintl(row)
            ystep(1);
        end
    end
    if strcmp(mode,'����')
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
    msgbox(['��ͼ��ɣ���ʱ��',...
        num2str(floor(h)),'h',...
        num2str(floor(min)),'min',...
        num2str(floor(sec)),'s;'],'��ͼ���');

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
    waitbar(1-nz/z,bar,'��ͼ������...');