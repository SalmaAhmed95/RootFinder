function [excutionTime,answer,bound] = NewtonRaphson(graphAx,initialGuess,f,var,maxIterations,predefinedError)
%Calculates the root of polynomial with the given parameters using NewtonRaphson methods

%using tic;toc; to calculate the elapsed time;
tic;
fDash = matlabFunction(symfun(diff(f,var), var));
fdoubleDash = matlabFunction(symfun(diff(fDash,var), var));

%initializing empty vectors to hold results
errorsVector = zeros(maxIterations,1);
iterationsVector=zeros(maxIterations,1);
appRootsVector=zeros(maxIterations,1);
errorabs = 1+predefinedError;
iterations = 1;
previousRootApproximation = initialGuess;

while errorabs>predefinedError && iterations<=maxIterations
 
    
  %handling division by zero
  
  if (fDash(previousRootApproximation) ==0)
      errordlg('Division byZero in Newton Raphson')
    
  end
  currentRootApproximation = previousRootApproximation  - (f(previousRootApproximation)/fDash(previousRootApproximation));
  iterationsVector (iterations) = iterations;
  errorabs=abs (currentRootApproximation-previousRootApproximation);
  errorsVector (iterations) = errorabs;
  appRootsVector(iterations) = currentRootApproximation;
  previousRootApproximation = currentRootApproximation; 
  iterations = iterations+1;
  
end
        iterationsVector(iterations : maxIterations) =[];
        appRootsVector(iterations : maxIterations) = [];
        errorsVector(iterations : maxIterations) = [];
        plotFunction(graphAx,f,fDash,initialGuess, appRootsVector(end));
        excutionTime = toc;
        deltaI = appRootsVector(end) - initialGuess;
        bound = abs(fdoubleDash(appRootsVector(end))/fDash(appRootsVector(end)))* (deltaI^2);
        answer = cat(2,iterationsVector,appRootsVector,errorsVector);
end
function plotFunction(graphAx, f, fDash, intialGuess,lastRoot)

% set start, end points for x margins
if (intialGuess < lastRoot)
    startPoint = intialGuess-1;
    endPoint = lastRoot+1;
else
    startPoint = lastRoot-1;
    endPoint = intialGuess+1;
end

margin = abs(endPoint - startPoint) / 5;

% set margins


axes(graphAx.ax1);
hold on;
fplot(f,[(startPoint - margin) (endPoint + margin)], 'color', 'black') % draw f(x)
fplot(fDash,[(startPoint - margin) (endPoint + margin)],'color', 'yellow') % draw g(x)

% fplot(f,[-1 1], 'color', 'black') % draw f(x)
% fplot(fDash,[-1 1],'color', 'yellow') % draw g(x)

limY = get(gca,'YLim');
limX = get(gca,'XLim');
disp(limY)
line(limX,[0 0], 'color', 'black'); % draw x-axis
line([intialGuess intialGuess], limY, 'color', 'yellow', 'LineStyle', '--'); % draw initial condition
line([lastRoot lastRoot],limY, 'color', 'green', 'LineStyle', '--'); % draw exact root

%set(gca,'YLim',[-1 1]);
grid on;
end
       
       