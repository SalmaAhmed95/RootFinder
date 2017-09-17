% reads different paramters for methods in part one in condition they have
% a string before each paramter expressing what it is ---->look txt file
% "inputParamtersTrial.txt"
function [lowerBound,upperBound,polynomial,maxIterations,error]=readParameters(fileName)
[lowerBound,upperBound,polynomial,maxIterations,error] = textread(fileName,'lowerBound%s upperBound%s polynomial%s maxIterations%s error%s', 1);
end