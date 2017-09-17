function [n,A,B] = readFile(fileName)
n=dlmread(fileName,' ',[0 0 0 0]);
A=dlmread(fileName,' ',[1 0 n n-1]);
B=dlmread(fileName,' ',[n+1 0 2*n 0]);

end