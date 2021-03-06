function varargout = zadanie1_v1(varargin)
% ZADANIE1_V1 MATLAB code for zadanie1_v1.fig
%      ZADANIE1_V1, by itself, creates a new ZADANIE1_V1 or raises the existing
%      singleton*.
%
%      H = ZADANIE1_V1 returns the handle to a new ZADANIE1_V1 or the handle to
%      the existing singleton*.
%
%      ZADANIE1_V1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ZADANIE1_V1.M with the given input arguments.
%
%      ZADANIE1_V1('Property','Value',...) creates a new ZADANIE1_V1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before zadanie1_v1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to zadanie1_v1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help zadanie1_v1

% Last Modified by GUIDE v2.5 20-Mar-2016 21:29:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @zadanie1_v1_OpeningFcn, ...
                   'gui_OutputFcn',  @zadanie1_v1_OutputFcn, ...
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


% --- Executes just before zadanie1_v1 is made visible.
function zadanie1_v1_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to zadanie1_v1 (see VARARGIN)

%Warunki pocz�tkowe
if get(handles.radiobutton_iteracje, 'Value')
    set(handles.edit7, 'enable', 'on');
end
if get(handles.radiobutton_dokladnosc, 'Value')
    set(handles.edit7, 'enable', 'off');
end

set(handles.text_errors, 'enable', 'off');

title('Wykres przedstawiaj�cy wprowadzon� funkcj�.');
xlabel('Warto�ci osi OX'); % x-axis label
ylabel('Warto�ci osi OY'); % y-axis label
grid on;
grid minor;
hold on;

%Ustawienia tabeli
cnames = {'Warto�ci X', 'Wato�ci Y', 'Warto�ci Z'};
set(handles.uitable2, 'RowName', cnames);

% Choose default command line output for zadanie1_v1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes zadanie1_v1 wait for user response (see UIRESUME)
%uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = zadanie1_v1_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(~, ~, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%pobieranie danych z "EditText"
wzor_string = get(handles.edit_wzor,'String');
wzor = str2func(wzor_string);
param_b = str2num(get(handles.edit_lkraniec, 'String'));
start_point = str2num(get(handles.edit_pkraniec, 'String'));

if get(handles.radiobutton_iteracje, 'Value')
    step = str2double(get(handles.edit7, 'String'));
    achiv = 0;
elseif get(handles.radiobutton_dokladnosc, 'Value')
    step = 0;
    achiv = 1;
end

%B�edy wprowadzenia
% if param >= b
%     set(handles.text_errors, 'Enable', 'on');
%     set(handles.text_errors, 'HorizontalAlignment', 'left');
%     set(handles.text_errors, 'String', 'Podano b��dny przedzia�.');
%     return;
% elseif step < 0
%     set(handles.text_errors, 'Enable', 'on');
%     set(handles.text_errors, 'HorizontalAlignment', 'left');
%     set(handles.text_errors, 'String', 'Podano b��dny krok iteracji.');
%     return;
% elseif achiv > (b - a)
%     set(handles.text_errors, 'Enable', 'on');
%     set(handles.text_errors, 'HorizontalAlignment', 'left');
%     set(handles.text_errors, 'String', 'Podano b��dn� dok�adno��.');
%     return;
% elseif isnan(param_b) || isnan(start_point) || isnan(step)
%     set(handles.text_errors, 'Enable', 'on');
%     set(handles.text_errors, 'HorizontalAlignment', 'left');
%     set(handles.text_errors, 'String', 'Wprowadzono b��dn� warto��.');
%     return;
% end

%Metody optymalizacji
[tab_x, last_x]=congradient(wzor, param_b, start_point, achiv, step);

%Informacja(wynik) na temat przedzia�u:
set(handles.text_errors, 'Enable', 'on');
set(handles.text_errors, 'HorizontalAlignment', 'left');
x_string = num2str(last_x(1,1));
y_string = num2str(last_x(2,1));
last_z = wzor(last_x(1,1), last_x(2,1));
z_string = num2str(last_z);
info_1 = 'Warto�� X:';
info_2 = 'Warto�� Y:';
info_3 = 'Warto�� Z:';
info = [info_1 char(10) x_string char(10) info_2 char(10) y_string char(10) info_3 char(10) z_string];
set(handles.text_errors, 'String', info);

%Wszystkie warto�ci
z = arrayfun(wzor, tab_x(1,:),tab_x(2,:));
x = tab_x(1,:);
y = tab_x(2,:);


%Rysowanie wykresu
w_temp = zeros(5,5);
%w_temp(:,1) = plot(x,y,'b');
w_temp(:,1) = ezsurf(wzor);
hold on;
w_temp(:,3) = scatter3(tab_x(1,:), tab_x(2,:), arrayfun(wzor, tab_x(1,:),tab_x(2,:)), [], [0.75 0.75 0], 'filled');
w_temp(:,2) = scatter3(start_point(1,1), start_point(2,1), wzor(start_point(1,1),start_point(2,1)), [], [0 0.75 0], 'filled');
w_temp(:,4) = scatter3(last_x(1,1), last_x(2,1), wzor(last_x(1,1), last_x(2,1)), [], [1 0 0], 'filled');
w_temp(:,5) = plot3(x, y, z, 'k',...
    'LineWidth', 2);

title('Wykres przedstawiaj�cy wprowadzon� funkcj�.');
xlabel('Warto�ci osi OX'); % x-axis label
ylabel('Warto�ci osi OY'); % y-axis label
grid on;
grid minor;
hold off;

set(w_temp(:,2), 'MarkerFaceColor', [0 0.75 0]);
set(w_temp(:,3), 'MarkerFaceColor', [0.75 0.75 0]);
set(w_temp(:,4), 'MarkerFaceColor', [1 0 0]);
set(w_temp(:,5), 'MarkerFaceColor', [0 0 0]);

legend(w_temp(1,:), 'Funkcja', 'Punkt pocz�tkowy', 'Punkty obliczane', 'Punkt ko�cowy', 'Linia skokow');

%Umieszczanie danych w tabeli.
set(handles.uitable2, 'Data', [tab_x(1,:);tab_x(1,:);z]);



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(~, ~, handles)
close(handles.figure1);
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in radiobutton_iteracje.
function radiobutton_iteracje_Callback(hObject, ~, handles)
% hObject    handle to radiobutton_iteracje (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject, 'Value')
    set(handles.edit7, 'enable', 'on');
end
% Hint: get(hObject,'Value') returns toggle state of radiobutton_iteracje


% --- Executes on button press in radiobutton_dokladnosc.
function radiobutton_dokladnosc_Callback(hObject, ~, handles)
% hObject    handle to radiobutton_dokladnosc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject, 'Value')
    set(handles.edit7, 'enable', 'off');
end
% Hint: get(hObject,'Value') returns toggle state of radiobutton_dokladnosc

% --------------------------------------------------------------------
function uipushtool2_ClickedCallback(~, ~, handles)
% hObject    handle to uipushtool2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

zdjecie = getframe(handles.axes1);
Image = frame2im(zdjecie);
imwrite(Image, 'Image.jpg')
