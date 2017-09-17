function [executionTime, answer,bound]=generalMethod(lowerBound,upperBound,fh, maxIterations,predefinedError)

%using tic;toc; to calculate the elapsed time;
 tic;
%initializing empty vectors to hold results
errorsVector = zeros(maxIterations,1);
iterationsVector=zeros(maxIterations,1);
appRootsVector=zeros(maxIterations,1);
bound =NaN;


if (fh(lowerBound)*fh(upperBound) >= 0 )
    disp('error root not within bounds');
    return;
end

if (abs(fh(lowerBound)) < abs(fh(upperBound)))
    temp=lowerBound;
    lowerBound=upperBound;
    upperBound=temp;
end
c =lowerBound;
flag=1;
approximateRoot=0;
d=0;
iterations=1;
error=abs(upperBound-lowerBound);
while error>predefinedError && iterations<maxIterations
    if fh(lowerBound) ~= fh(c) && fh(upperBound) ~= fh(c)
        %quadratic interpolation
        approximateRoot =( lowerBound * fh(upperBound) * fh(c) / ((fh(lowerBound) - fh(upperBound)) * (fh(lowerBound) - fh(c))) )+ ( upperBound * fh(lowerBound) * fh(c) / ((fh(upperBound) - fh(lowerBound)) * (fh(upperBound) - fh(c))) )+ ( c * fh(lowerBound) * fh(upperBound) / ((fh(c) - fh(lowerBound)) * (fh(c) - fh(upperBound))) );
    else
        %secant
        approximateRoot = upperBound - fh(upperBound) * (upperBound - lowerBound) / (fh(upperBound) - fh(lowerBound));
    end
    
    if (( (approximateRoot < (3 * lowerBound +upperBound )/4) || (approximateRoot > upperBound) ) ||( flag==1 && (abs(approximateRoot-upperBound) >= (abs(upperBound-c) /2)) ) ||( flag==0 && (abs(approximateRoot-upperBound) >= (abs(c-d)/2)) ) ||( flag==1 && (abs(upperBound-c) < predefinedError) ) || (flag==0 && (abs(c-d) < predefinedError)))
        %bisection
        approximateRoot= (lowerBound+upperBound)/2;
        flag=1;
    else
        flag=0;
    end
    
    d = c ;
    c = upperBound;
    if (fh(lowerBound)*fh(approximateRoot) < 0 )
        upperBound = approximateRoot ;
    else
        lowerBound = approximateRoot;
    end
    if abs(fh(lowerBound)) < abs(fh(upperBound))
        temp=lowerBound;
        lowerBound=upperBound;
        upperBound=temp;
    end
    error=abs(upperBound-lowerBound);
    iterationsVector(iterations) = iterations;
    appRootsVector(iterations) = approximateRoot;
    errorsVector(iterations) = error;
    iterations=iterations+1;
    
end
errorsVector(iterations: maxIterations) =[];
appRootsVector(iterations : maxIterations) =[];
iterationsVector(iterations : maxIterations) =[];
executionTime = toc;
answer = cat(2,iterationsVector,appRootsVector,errorsVector);
       fID = fopen('Results.txt','w');
       fprintf(fID,'%f\t\t%f\t\t%f\t\t\n\n', [iterationsVector,appRootsVector ,errorsVector]);
end