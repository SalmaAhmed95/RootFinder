function [excutionTime, answer,bound]  = FalsePosition(graphAx,lowerBound,upperBound,fh,maxIterations,predefinedError)
%Calculates the root of polynomial with the given parameters using Flase-position methods

tic;
%initializing empty vectors to hold results
errorsVector = zeros(maxIterations,1);
iterationsVector=zeros(maxIterations,1);
appRootsVector=zeros(maxIterations,1);
xlower = zeros(maxIterations,1);
xupper = zeros(maxIterations,1);
fX = zeros(maxIterations,1);
error = 100;
iterations = 1;
plotFunction(graphAx,lowerBound,upperBound,fh)
previousRootApproximation =0 ;

while error>predefinedError && iterations<=maxIterations
  
    
  currentRootApproximation = ((lowerBound*fh(upperBound)) - (upperBound*fh(lowerBound)))/(fh(upperBound)-fh(lowerBound));
   xlower(iterations) = lowerBound;
   xupper(iterations) = upperBound;
   
  checkFunction = fh(currentRootApproximation);
  fX(iterations) = checkFunction;
  if (checkFunction <0)
    if (fh(lowerBound)<0)
    lowerBound = currentRootApproximation;
      else
     upperBound = currentRootApproximation;
    end;
  elseif (checkFunction >0)
     if (fh(lowerBound)>0)
    lowerBound = currentRootApproximation;
      else
     upperBound = currentRootApproximation;
      end;
  elseif (checkFunction ==0) 
  iterationsVector (iterations) = iterations;
  error = abs(currentRootApproximation-previousRootApproximation);
  errorsVector (iterations) = error;
  previousRootApproximation = currentRootApproximation;
  appRootsVector (iterations)= previousRootApproximation;
  iterations = iterations+1;
    break
  end
  iterationsVector (iterations) = iterations;
  error = abs(currentRootApproximation-previousRootApproximation);
  errorsVector (iterations) = error;
  previousRootApproximation = currentRootApproximation;
  appRootsVector (iterations)= previousRootApproximation;
  iterations = iterations+1;
  
end
       errorsVector(1,1) = NaN;
       errorsVector(iterations: maxIterations) =[];
       appRootsVector(iterations : maxIterations) =[];
       iterationsVector(iterations : maxIterations) =[];
       xlower(iterations : maxIterations) = [];
       xupper(iterations : maxIterations) =[];  
       fX(iterations : maxIterations) =[];  
       excutionTime = toc;
       bound = NaN;
       answer = cat(2,iterationsVector,appRootsVector,xlower,xupper,fX,errorsVector);
end

function plotFunction(graphAx,lowerBound,upperBound,fh)
  start = lowerBound;
  finish = upperBound;
    if (fh(lowerBound) > 0)
    temp_date=start;
    start= finish;
    finish=temp_date;
    end;

axes(graphAx.ax1);
hold on
ratiox = abs( upperBound -lowerBound)/5;
ratioY = abs(fh(lowerBound)-fh(upperBound))/5;
set(gca,'YLim',[fh(start)-ratioY fh(finish)+ratioY]);

line([0 0],[fh(start)-ratioY fh(finish)+ratioY],'color','black');
line([(lowerBound-ratiox) (upperBound+ratiox)],[0 0],'color','black');

fplot (fh,[(lowerBound-ratiox) (upperBound+ratiox)])
line([lowerBound lowerBound],[fh(start)-ratioY fh(finish)+ratioY],'color','red','LineStyle','--');
line([upperBound upperBound],[fh(start)-ratioY fh(finish)+ratioY],'color','green','LineStyle','--');

line([lowerBound upperBound],[fh(lowerBound) fh(upperBound)],'color','yellow');
grid on
hold off
end
       