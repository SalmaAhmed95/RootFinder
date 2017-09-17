function [equationsNumber,equations,initial,maxIterations,error]=readEquations(fileName)
fid=fopen(fileName);
tline = fgetl(fid);
equationsNumber=str2num(tline);
equations = cell(0,1);
tline = fgetl(fid);
for i=1:equationsNumber
    equations{end+1,1} = tline;
    tline = fgetl(fid);
end
maxIterations=tline;
error=fgetl(fid);
initial = dlmread(fileName,',',equationsNumber+3,0);
end
