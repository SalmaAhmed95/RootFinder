function [excutionTime,answer,bound] = BirgeVieta( graphAx,x0,coffA,f,maxIterations,predefinedError )
%calculates the root of the function using birgeVeita

% starts timer
   tic;
   bound = NaN;
 %intializes the array
   prevapproxRoot=x0;
   errorVector =zeros(maxIterations,1);
   rootVector = zeros(maxIterations,1);
   iterations = zeros(maxIterations,1);
   bL = zeros(maxIterations,1);
   cL = zeros(maxIterations,1);
   absErr = predefinedError+1;
   iterCounter =1;
   sizeA = size(coffA,2);
  
 while (absErr > predefinedError && iterCounter <= maxIterations)
         bi = coffA(1);
         ci = bi;
         for i = 2 : 1 : (sizeA-1)
          bi = coffA(i)+ ( prevapproxRoot*bi);
          ci = bi + ( prevapproxRoot*ci);
%           
         end;
        
         bi = coffA(end)+( prevapproxRoot * bi);    
         currentapproxRoot =  prevapproxRoot - (bi/ci);
         absErr = abs ( currentapproxRoot-prevapproxRoot);
         iterations(iterCounter) =  iterCounter;
         rootVector(iterCounter) =  currentapproxRoot;
         errorVector(iterCounter) = absErr;
         bL (iterCounter) = bi;
         cL (iterCounter) = ci;
         prevapproxRoot = currentapproxRoot;
         iterCounter = iterCounter + 1;
         if (f(bi)==0)
             break;
         end;
 end;
  

   errorVector(iterCounter: maxIterations) =[];
   rootVector(iterCounter : maxIterations) =[];
   iterations(iterCounter : maxIterations) =[];
   bL(iterCounter : maxIterations) =[];
   cL(iterCounter : maxIterations) =[];
   
    plotFunction(graphAx,f)
    excutionTime = toc;
   answer = cat(2,iterations,rootVector,bL,cL,errorVector);
end

function plotFunction(graphAx,f)
axes(graphAx.ax1);
hold on;
fplot(f,[-5 5], 'color', 'black') % draw f(x)
grid on;
end

