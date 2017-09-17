function [excutionTime,answer,bound]  = Secant(graphAx,firstGuess,secondGuess,fh,maxIterations,predefinedError)
%Calculates the root of polynomial with the given parameters using Secant methods
 
 
%using tic;toc; to calculate the elapsed time;
tic;
%initializing empty vectors to hold results
errorsVector = zeros(maxIterations,1);
iterationsVector=zeros(maxIterations,1);
appRootsVector=zeros(maxIterations,1);
xi1 = zeros(maxIterations,1);
xi2 = zeros (maxIterations,1);
fxi1 = zeros(maxIterations,1);
fxi2 = zeros(maxIterations,1);
bound = NaN;
errorabs = 100;
iterations =1;
 
beforePreviousRootApproximation = firstGuess;
previousRootApproximation = secondGuess;
 
while errorabs>predefinedError && iterations<=maxIterations
 
  xi1 (iterations) = beforePreviousRootApproximation;
  xi2 (iterations) = previousRootApproximation;
  fxi1(iterations) = fh(beforePreviousRootApproximation);
  fxi2(iterations) = fh(previousRootApproximation);
  formulaNumerator = fh(previousRootApproximation)*(beforePreviousRootApproximation-previousRootApproximation);
  formulaDenominator = fh(beforePreviousRootApproximation)-fh(previousRootApproximation);
 
  if (formulaDenominator == 0)
    error('Division by Zero');
  end;
  currentRootApproximation = previousRootApproximation  - formulaNumerator/formulaDenominator;
  iterationsVector (iterations)= iterations;
  errorabs = abs(currentRootApproximation-previousRootApproximation);
  errorsVector(iterations) = errorabs;
  appRootsVector (iterations) = currentRootApproximation;
  beforePreviousRootApproximation = previousRootApproximation;
  previousRootApproximation = currentRootApproximation;
  iterations = iterations + 1;
 
end
   
       errorsVector(1,1) = NaN;
       errorsVector(iterations: maxIterations) =[];
       appRootsVector(iterations : maxIterations) =[];
       iterationsVector(iterations : maxIterations) =[];
       xi1(iterations : maxIterations) = [];
       xi2(iterations : maxIterations) =[];
       fxi1(iterations : maxIterations) = [];
       fxi2(iterations : maxIterations) =[];
       excutionTime = toc;
       plotFunction(graphAx,firstGuess,secondGuess,appRootsVector(end),fh);
       answer = cat(2,iterationsVector,appRootsVector,xi1,xi2,fxi1,fxi2,errorsVector);
%        fID = fopen('Results.txt','w');
%        fprintf(fID,'%f\t\t%f\t\t%f\t\t\n\n', [iterationsVector,appRootsVector xi1 xi2 fxi1 fxi2 errorsVector]);
       
       
end
function plotFunction(graphAx,intialGuess,secondGuess,lastRoot,f)
 
graphPoints = [intialGuess,secondGuess,lastRoot];
 
    startPoint = min(graphPoints);
    endPoint = max(graphPoints);
 
 
margin = abs(endPoint - startPoint) / 5;
axes(graphAx.ax1);
hold on
fplot(f,[(startPoint - margin) (endPoint + margin)], 'color', 'black') % draw f(x)
 
 
limY = get(gca,'YLim');
limX = get(gca,'XLim');
disp(limY)
line(limX,[0 0], 'color', 'black'); % draw x-axis
line([intialGuess intialGuess], limY, 'color', 'yellow', 'LineStyle', '--');
line([intialGuess secondGuess], [f(intialGuess) f(secondGuess)], 'color', 'black');% draw initial condition
line([secondGuess secondGuess],limY, 'color', 'green', 'LineStyle', '--'); % draw exact root
 
grid on
hold off
end