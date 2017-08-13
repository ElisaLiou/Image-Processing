function varargout = Pythagor_tree_system(varargin)
% PYTHAGOR_TREE_SYSTEM MATLAB code for Pythagor_tree_system.fig
%      PYTHAGOR_TREE_SYSTEM, by itself, creates a new PYTHAGOR_TREE_SYSTEM or raises the existing
%      singleton*.
%
%      H = PYTHAGOR_TREE_SYSTEM returns the handle to a new PYTHAGOR_TREE_SYSTEM or the handle to
%      the existing singleton*.
%
%      PYTHAGOR_TREE_SYSTEM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PYTHAGOR_TREE_SYSTEM.M with the given input arguments.
%
%      PYTHAGOR_TREE_SYSTEM('Property','Value',...) creates a new PYTHAGOR_TREE_SYSTEM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Pythagor_tree_system_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Pythagor_tree_system_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Pythagor_tree_system

% Last Modified by GUIDE v2.5 19-Sep-2016 01:31:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Pythagor_tree_system_OpeningFcn, ...
                   'gui_OutputFcn',  @Pythagor_tree_system_OutputFcn, ...
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


% --- Executes just before Pythagor_tree_system is made visible.
function Pythagor_tree_system_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Pythagor_tree_system (see VARARGIN)

% Choose default command line output for Pythagor_tree_system
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Pythagor_tree_system wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Pythagor_tree_system_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

varargout{1} = handles.output;

function radiobutton1_Callback(hObject, eventdata, handles)
function radiobutton2_Callback(hObject, eventdata, handles)

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    disthandle=get(handles.uipanel1,'SelectedObject');
    disttype=get(disthandle, 'String');
    counter = 1;
    set(gcf,'User', counter);
    switch disttype
    case ' 3: 4: 5'
        cla(findobj('Type','axes','Tag','axes1'));
        m=3/4;
        set(gcf,'Name',num2str(m));
        set(gcf, 'WindowButtonDownFcn', @clicker);  %add the clicker actionlistener
        Pythagor_tree(m,1,'summer');
    case ' 5:12:13'
        cla(findobj('Type','axes','Tag','axes1'));
        m=5/12;
        set(gcf,'Name',num2str(m));
        set(gcf, 'WindowButtonDownFcn', @clicker);  %add the clicker actionlistener
        Pythagor_tree(m,1,'summer');
    end
 
% function called on mouse click in the figure
function clicker(h,~)
    counter = get(gcf, 'User');
    m=str2num(get(gcf,'Name'));
    type=get(gcf, 'selectiontype');
    % 'normal' for left moue button
    % 'alt' for right mouse button
    % 'extend' for middle mouse button
    % 'open' on double click
    switch type
       case 'normal'
           cla(findobj('Type','axes','Tag','axes1'));
           counter = counter +1;
           set(gcf, 'User', counter);
           Pythagor_tree(m,counter,'summer');
       case 'alt';
            if counter<2 counter=2; end
           cla(findobj('Type','axes','Tag','axes1'));
           counter = counter -1;
           set(gcf, 'User', counter);
           Pythagor_tree(m,counter,'summer');
           
    end

    
function M = Pythagor_tree(m,n,Colormap)
% Check if the inputs has any error
if m <= 0
	error([mfilename ':e0'],'Length of m has to be greater than zero');
end
if rem(n,1)~=0
	error([mfilename ':e0'],'The number of level has to be integer');
end
if ~iscolormap(Colormap)
	error([mfilename ':e1'],'Input colormap is not valid');
end
% Constants
d      = sqrt(1+m^2);                  
c1     = 1/d;                          % Normalized length 1
c2     = m/d;                          % Normalized length 2
T      = [0 1/(1+m^2);1 1+m/(1+m^2)];  % Translation pattern  
alpha1 = atan2(m,1);                   % Defines the first rotation angle
alpha2 = alpha1-pi/2;                  % Defines the second rotation angle
pi2    = 2*pi;                         % Defines pi2
nEle   = 2^(n+1)-1;                    % Number of elements (square)
M      = zeros(nEle,5);                % Matrice containing the tree
M(1,:) = [0 -1 0 1 1];                 % Initialization of the tree

% Compute the level of each square contained in the resulting matrix
Offset = 0;
for i = 0:n
    tmp = 2^i;
    M(Offset+(1:tmp),5) = i;
    Offset = Offset + tmp;
end
% Compute the position and size of each square wrt its parent
for i = 2:2:(nEle-1)
    j          = i/2;    
    mT         = M(j,4) * mat_rot(M(j,3)) * T;
    Tx         = mT(1,:) + M(j,1);
    Ty         = mT(2,:) + M(j,2);  
    theta1     = rem(M(j,3)+alpha1,pi2);
    theta2     = rem(M(j,3)+alpha2,pi2);
    M(i  ,1:4) = [Tx(1) Ty(1) theta1 M(j,4)*c1];
    M(i+1,1:4) = [Tx(2) Ty(2) theta2 M(j,4)*c2];
end
% Display the tree
Pythagor_tree_plot(M,n);

%rotate the square
function M = mat_rot(x)
c = cos(x);
s = sin(x);
M=[c -s; s c];


%display tree
function H = Pythagor_tree_plot(D,ColorM)
if numel(ColorM) == 1
    ColorM = summer(ColorM+1); %change color
end
H = findobj('Type','axes','Tag','axes1'); %display the result in axes1
hold on
axis equal
axis off
axis([-5.5, 5.5, -1.5, 4]) %fix the size of axes1

for i=1:size(D,1)
    cx    = D(i,1);
    cy    = D(i,2);
    theta = D(i,3);
    si    = D(i,4);    
    M     = mat_rot(theta);
    x     = si*[0 1 1 0 0];
    y     = si*[0 0 1 1 0];
    pts   = M*[x;y];
    fill(cx+pts(1,:),cy+pts(2,:),ColorM(D(i,5)+1,:),'edgealpha',0);
    % plot(cx+pts(1,1:2),cy+pts(2,1:2),'r');
end
   

%colormap comfirm
function  res = iscolormap(cmap)
% This function returns true if 'cmap' is a valid colormap
LCmap = {...
    'autumn'
    'bone'
    'colorcube'
    'cool'
    'copper'
    'flag'
    'gray'
    'hot'
    'hsv'
    'jet'
    'lines'
    'pink'
    'prism'
    'spring'
    'summer'
    'white'
    'winter'
};

res = ~isempty(strmatch(cmap,LCmap,'exact'));
