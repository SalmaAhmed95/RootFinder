function [A , b,variables]=readEquations(fileName)
fid=fopen(fileName);
tline = fgetl(fid);
equationsNumber=str2num(tline);
tlines = cell(0,1);
while ischar(tline)
    tlines{end+1,1} = tline;
    tline = fgetl(fid);
end
%intialization for empty variable of sym
 equations=sym.empty(equationsNumber,0);
for i=1:equationsNumber
equations(i)=sym(lines(i));
end

for i=1:equationsNumber
equations(i)=sym(tlines(i+1));
end
  variables = symvar(equations);
[A,b]=equationsToMatrix(equations,variables);
end
