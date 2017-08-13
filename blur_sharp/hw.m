function varargout = blur_sharp(varargin)
% HW MATLAB code for hw.fig
%      HW, by itself, creates a new HW or raises the existing
%      singleton*.
%
%      H = HW returns the handle to a new HW or the handle to
%      the existing singleton*.
%
%      HW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HW.M with the given input arguments.
%
%      HW('Property','Value',...) creates a new HW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before hw_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to hw_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help hw

% Last Modified by GUIDE v2.5 23-Nov-2015 18:06:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @hw_OpeningFcn, ...
                   'gui_OutputFcn',  @hw_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before hw is made visible.
function hw_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to hw (see VARARGIN)

% Choose default command line output for hw
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes hw wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = hw_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%按讀取
% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton2.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%讀取一張影像
[filename, pathname, filterindex]  = uigetfile({'*.jpg';'*.bmp'},'Select an image');
handles.img = imread([pathname filename]);
info=imfinfo(filename);
handles.colortype=info.ColorType;

%將影像print在axes上
axes(handles.axes1)
imshow(handles.img)
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


%按送出運算
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%r將讀取到的影像存進img變數
img=handles.img;

%判斷是否為灰階
ans=strcmp(handles.colortype,'grayscale');
if(ans==1)%若為灰階影像
        I = double(img);
        n = str2num(get(handles.edit1,'String'));%以edit text輸入值修改模糊大小

        bl=1;
        f(1:n,1:n)=bl;   %a即n×n模板,元素全是bl 
        x1=double(img); 
        x2=x1;  %A(a:b,c:d)表示A矩陣的第a到b行,第c到d列的所有元素 
        for i=1:size(I,1)-n+1     
            for j=1:size(I,2)-n+1          
                c=x1(i:i+(n-1),j:j+(n-1)).*f; %取出x1中(i,j)的n行n列元素與模板相乘         
                s=sum(sum(c));                 %求c矩陣(即模板)中各元素之和          
                x2(i+(n-1)/2,j+(n-1)/2)=s/(n*n); %模板各元素的均值 模板中心位置的元素     
            end
        end
        %處理後的影像顯示在axes2
        axes(handles.axes2)
        imshow(uint8(x2));

    %Sharp
    x3 = x1;
    a = str2num(get(handles.edit2,'String'));%以edit text輸入內容修改影像銳利度
    b = 1;
    for i=1:size(I,1)    
        for j=1:size(I,2) 
            x3(i,j) = (x1(i,j) - x2(i,j)).*a  + x1(i,j).*b;
        end
    end
    
    %處理後的影像顯示於axes3
    axes(handles.axes3)
    imshow(uint8(x3));
    
%若為彩色影像
else 
    %分別以RGP三個通道讀取image
    r = img(:,:,1);
    g = img(:,:,2);
    b = img(:,:,3);

    %casting
    I = double(img);
    R = double(r);
    G = double(g);
    B = double(b);

    %模板
    n = str2num(get(handles.edit1,'String'));%以edit text輸入值修改模糊大小
    bl=1;
    f(1:n,1:n)=bl;   %a即n×n模板,元素全是bl 

    %三個變數存取blur後的RGB
    R2=R; 
    G2=G;
    B2=B;

    %R均值模糊運算
    for i=1:size(R,1)-n+1     
        for j=1:size(R,2)-n+1          
            c=R(i:i+(n-1),j:j+(n-1)).*f; %取出x1中(i,j)的n行n列元素與模板相乘         
            s=sum(sum(c));                 %求c矩陣(即模板)中各元素之和          
            R2(i+(n-1)/2,j+(n-1)/2)=s/(n*n); %模板各元素的均值 模板中心位置的元素     
        end
    end

    %G均值模糊運算
    for i=1:size(G,1)-n+1     
        for j=1:size(G,2)-n+1          
            c=G(i:i+(n-1),j:j+(n-1)).*f; %取出x1中(i,j)的n行n列元素與模板相乘         
            s=sum(sum(c));                 %求c矩陣(即模板)中各元素之和          
            G2(i+(n-1)/2,j+(n-1)/2)=s/(n*n); %模板各元素的均值 模板中心位置的元素     
        end
    end

    %B均值模糊運算
    for i=1:size(B,1)-n+1     
        for j=1:size(B,2)-n+1          
            c=B(i:i+(n-1),j:j+(n-1)).*f; %取出x1中(i,j)的n行n列元素與模板相乘         
            s=sum(sum(c));                 %求c矩陣(即模板)中各元素之和          
            B2(i+(n-1)/2,j+(n-1)/2)=s/(n*n); %模板各元素的均值 模板中心位置的元素     
        end
    end

    %變數D2將R2 G2 B2存回一張圖
    D2(:,:,1)=R2;
    D2(:,:,2)=G2;
    D2(:,:,3)=B2;

    %模糊後的影像輸出在axes2
    axes(handles.axes2)
    imshow(uint8(D2));

    %Sharp
    %三個變數存取瑞利化後的RGB
    R3=R;
    G3=G;
    B3=B;
    a = str2num(get(handles.edit2,'String'));%以edit text輸入內容修改影像銳利度
    b = 1;

    %R的銳利化運算
    for i=1:size(R,1)    
        for j=1:size(R,2) 
            R3(i,j,:) = (R(i,j,:) - R2(i,j,:)).*a  + R(i,j,:).*b;
        end
    end

    %G的銳利化運算
    for i=1:size(G,1)    
        for j=1:size(G,2) 
            G3(i,j,:) = (G(i,j,:) - G2(i,j,:)).*a  + G(i,j,:).*b;
        end
    end

    %B的銳利化運算
    for i=1:size(B,1)    
        for j=1:size(B,2) 
            B3(i,j,:) = (B(i,j,:) - B2(i,j,:)).*a  + B(i,j,:).*b;
        end
    end

    
    %D3合併修改後的RGB
    D3(:,:,1)=R3;
    D3(:,:,2)=G3;
    D3(:,:,3)=B3;

    %銳利化後的影像輸出在axes3
    axes(handles.axes3)
    imshow(uint8(D3))
end

%按離開結束程式
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear all
close