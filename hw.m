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

%��Ū��
% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton2.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Ū���@�i�v��
[filename, pathname, filterindex]  = uigetfile({'*.jpg';'*.bmp'},'Select an image');
handles.img = imread([pathname filename]);
info=imfinfo(filename);
handles.colortype=info.ColorType;

%�N�v��print�baxes�W
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


%���e�X�B��
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%r�NŪ���쪺�v���s�iimg�ܼ�
img=handles.img;

%�P�_�O�_���Ƕ�
ans=strcmp(handles.colortype,'grayscale');
if(ans==1)%�Y���Ƕ��v��
        I = double(img);
        n = str2num(get(handles.edit1,'String'));%�Hedit text��J�ȭק�ҽk�j�p

        bl=1;
        f(1:n,1:n)=bl;   %a�Yn��n�ҪO,�������Obl 
        x1=double(img); 
        x2=x1;  %A(a:b,c:d)���A�x�}����a��b��,��c��d�C���Ҧ����� 
        for i=1:size(I,1)-n+1     
            for j=1:size(I,2)-n+1          
                c=x1(i:i+(n-1),j:j+(n-1)).*f; %���Xx1��(i,j)��n��n�C�����P�ҪO�ۭ�         
                s=sum(sum(c));                 %�Dc�x�}(�Y�ҪO)���U�������M          
                x2(i+(n-1)/2,j+(n-1)/2)=s/(n*n); %�ҪO�U���������� �ҪO���ߦ�m������     
            end
        end
        %�B�z�᪺�v����ܦbaxes2
        axes(handles.axes2)
        imshow(uint8(x2));

    %Sharp
    x3 = x1;
    a = str2num(get(handles.edit2,'String'));%�Hedit text��J���e�ק�v���U�Q��
    b = 1;
    for i=1:size(I,1)    
        for j=1:size(I,2) 
            x3(i,j) = (x1(i,j) - x2(i,j)).*a  + x1(i,j).*b;
        end
    end
    
    %�B�z�᪺�v����ܩ�axes3
    axes(handles.axes3)
    imshow(uint8(x3));
    
%�Y���m��v��
else 
    %���O�HRGP�T�ӳq�DŪ��image
    r = img(:,:,1);
    g = img(:,:,2);
    b = img(:,:,3);

    %casting
    I = double(img);
    R = double(r);
    G = double(g);
    B = double(b);

    %�ҪO
    n = str2num(get(handles.edit1,'String'));%�Hedit text��J�ȭק�ҽk�j�p
    bl=1;
    f(1:n,1:n)=bl;   %a�Yn��n�ҪO,�������Obl 

    %�T���ܼƦs��blur�᪺RGB
    R2=R; 
    G2=G;
    B2=B;

    %R���ȼҽk�B��
    for i=1:size(R,1)-n+1     
        for j=1:size(R,2)-n+1          
            c=R(i:i+(n-1),j:j+(n-1)).*f; %���Xx1��(i,j)��n��n�C�����P�ҪO�ۭ�         
            s=sum(sum(c));                 %�Dc�x�}(�Y�ҪO)���U�������M          
            R2(i+(n-1)/2,j+(n-1)/2)=s/(n*n); %�ҪO�U���������� �ҪO���ߦ�m������     
        end
    end

    %G���ȼҽk�B��
    for i=1:size(G,1)-n+1     
        for j=1:size(G,2)-n+1          
            c=G(i:i+(n-1),j:j+(n-1)).*f; %���Xx1��(i,j)��n��n�C�����P�ҪO�ۭ�         
            s=sum(sum(c));                 %�Dc�x�}(�Y�ҪO)���U�������M          
            G2(i+(n-1)/2,j+(n-1)/2)=s/(n*n); %�ҪO�U���������� �ҪO���ߦ�m������     
        end
    end

    %B���ȼҽk�B��
    for i=1:size(B,1)-n+1     
        for j=1:size(B,2)-n+1          
            c=B(i:i+(n-1),j:j+(n-1)).*f; %���Xx1��(i,j)��n��n�C�����P�ҪO�ۭ�         
            s=sum(sum(c));                 %�Dc�x�}(�Y�ҪO)���U�������M          
            B2(i+(n-1)/2,j+(n-1)/2)=s/(n*n); %�ҪO�U���������� �ҪO���ߦ�m������     
        end
    end

    %�ܼ�D2�NR2 G2 B2�s�^�@�i��
    D2(:,:,1)=R2;
    D2(:,:,2)=G2;
    D2(:,:,3)=B2;

    %�ҽk�᪺�v����X�baxes2
    axes(handles.axes2)
    imshow(uint8(D2));

    %Sharp
    %�T���ܼƦs����Q�ƫ᪺RGB
    R3=R;
    G3=G;
    B3=B;
    a = str2num(get(handles.edit2,'String'));%�Hedit text��J���e�ק�v���U�Q��
    b = 1;

    %R���U�Q�ƹB��
    for i=1:size(R,1)    
        for j=1:size(R,2) 
            R3(i,j,:) = (R(i,j,:) - R2(i,j,:)).*a  + R(i,j,:).*b;
        end
    end

    %G���U�Q�ƹB��
    for i=1:size(G,1)    
        for j=1:size(G,2) 
            G3(i,j,:) = (G(i,j,:) - G2(i,j,:)).*a  + G(i,j,:).*b;
        end
    end

    %B���U�Q�ƹB��
    for i=1:size(B,1)    
        for j=1:size(B,2) 
            B3(i,j,:) = (B(i,j,:) - B2(i,j,:)).*a  + B(i,j,:).*b;
        end
    end

    
    %D3�X�֭ק�᪺RGB
    D3(:,:,1)=R3;
    D3(:,:,2)=G3;
    D3(:,:,3)=B3;

    %�U�Q�ƫ᪺�v����X�baxes3
    axes(handles.axes3)
    imshow(uint8(D3))
end

%�����}�����{��
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear all
close