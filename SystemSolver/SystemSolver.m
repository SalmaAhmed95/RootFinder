function varargout = SystemSolver(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @SystemSolver_OpeningFcn, ...
    'gui_OutputFcn',  @SystemSolver_OutputFcn, ...
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


% --- Executes just before SystemSolver is made visible.
function SystemSolver_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for SystemSolver
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = SystemSolver_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;

% ----------------------------------------------------------------------------------
% Creation Functions: Executed during object creation, after setting all properties.
% ----------------------------------------------------------------------------------

function num_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function equations_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function methodList_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function maxIterations_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function precision_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function guesses_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function solution_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function filename_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function v_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% -------------------
% Callback Functions:
% -------------------

function num_Callback(hObject, eventdata, handles)

function equations_Callback(hObject, eventdata, handles)

function methodList_Callback(hObject, eventdata, handles)

function guesses_Callback(hObject, eventdata, handles)

function maxIterations_Callback(hObject, eventdata, handles)

function precision_Callback(hObject, eventdata, handles)

function filename_Callback(hObject, eventdata, handles)

function v_Callback(hObject, eventdata, handles)

function setNum_Callback(hObject, eventdata, handles)
n = str2double(get(handles.num,'String')); % #equations in the system
set(handles.equations, 'Max', n);
set(handles.guesses, 'Max', n);
set(handles.solution, 'Max', n);
set(handles.prec, 'Max', n);

function readFile_Callback(hObject, eventdata, handles)
fileName = get(handles.filename,'String');
[n,e,initial,maxIterations,error] = readEquations(fileName);
guess='';
space=' ';
symEQ = sym.empty(n,0);
for i = 1 : n
    symEQ(i) = sym(lines(i));
    symEQ(i) = sym(e(i,:));
end
vars = symvar(symEQ);
for i=1:n
 guess = sprintf('%s%s%s%s\n', guess, char(vars(i)),space,num2str(initial(i)));   
end
set(handles.num,'String',n);
set(handles.equations, 'Max', n);
set(handles.guesses, 'Max', n);
set(handles.solution, 'Max', n);
set(handles.equations,'String',e);
set(handles.maxIterations,'String',maxIterations);
set(handles.precision,'String',error);
set(handles.guesses,'String', guess);
guidata(hObject,handles);

function solveBtn_Callback(hObject, eventdata, handles)
methods = cellstr(get(handles.methodList,'String')); % cell array containing all methods in the list
selected = methods{get(handles.methodList,'Value')}; % selected method
eqs = get(handles.equations,'String'); % input equation as (string)
n = get(handles.equations,'Max');
symEQ = sym.empty(n,0);
for i = 1 : n
    symEQ(i) = sym(lines(i));
    symEQ(i) = sym(eqs(i,:));
end
vars = symvar(symEQ);
[A, b] = equationsToMatrix(symEQ,vars);

if(strcmp(selected, 'Gauss Sidel') || strcmp(selected, 'All'))
    init = get(handles.guesses,'String')
        initials = zeros(n, 1);
        for i = 1 : n
            s = (strsplit(init(i, :)));
            guess = double(sym(s(1, 2)));
            initials(i, 1) = guess;
        end
        iMax = str2double(get(handles.maxIterations,'String')); % max #iterations
        Es = str2double(get(handles.precision,'String')); % desired precision
        if (isnan(iMax))
            iMax = 50; % default maximum iterations
        end
        if (isnan(Es))
            Es = 0.00001; % default EPSILON
        end
end

switch selected
    case 'Gaussian Elimination'
        [x,executionTime] = GaussianElimination(A,b,vars);
    case 'Gauss Jordan'
        [x,executionTime] = GaussJordan(A,b,vars);
    case 'LU Decomposition'
        [L,U,x,executionTime] = LUDecomposition(A,b,vars);
    case 'Gauss Sidel'
        [x, err, roots, executionTime] = GaussSidel( A, b, vars, Es, iMax, initials);
        set(handles.prec, 'String', err);
        % plot Sidel
        index = str2double(get(handles.v,'String'));
        plotMultipleRoots(handles, roots, index);
    case 'All'
        [xGauss, tGauss] = GaussianElimination(A,b,vars);
        [xJordan, tJordan] = GaussJordan(A,b,vars);
        [L, U, xLU, tLU] = LUDecomposition(A,b,vars);
        [xSidel, err, roots, tSidel] = GaussSidel( A, b, vars, Es, iMax, initials);
end

if (~strcmp(selected, 'All'))
    sol = '';
    for i = 1 : n
        var = char(vars(i));
        equ = ' = ';
        val = double(x(i));
        sol = sprintf('%s%s%s%f\n', sol, var, equ, val)
    end
    set(handles.solution, 'String', sol);
    set(handles.time, 'String', executionTime);
else
    colNames = cell(n + 1, 1);
    for i = 1 : n
        colNames(i, 1) = java.lang.String(char(vars(i)));
    end
    colNames(n + 1, 1) = java.lang.String('Execution Time');
    set(handles.table, 'ColumnName', colNames);
    set(handles.table,'RowName',{'Gaussian Elimination'; 'Gauss Jordan'; 'LU Decomposition'; 'Gauss Sidel'});
    data = zeros(4, n + 1);
    for i = 1 : n
        data(1, i) = double(xGauss(i));
        data(2, i) = double(xJordan(i));
        data(3, i) = double(xLU(i));
        data(4, i) = double(xSidel(i));
    end
    data(1, n + 1) = tGauss;
    data(2, n + 1) = tJordan;
    data(3, n + 1) = tLU;
    data(4, n + 1) = max(tSidel);
    set(handles.table,'Data',data);
    % plot Sidel
    index = str2double(get(handles.v,'String'));
    plotMultipleRoots(handles, roots, index);
end
