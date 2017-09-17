function [answer,executionTime] = GaussJordan(A,B,vars)
  %solves systems of linear equations using Gauss-Jordan Elimination
  
  %A is coefficients matrix : Ax=b
  
  tic;
  
  dimensions = size(A);
  if (dimensions(1)~=dimensions(2))
    error('coefficients matrix must be a square matrix');
  end
  n = dimensions(1);
  %Augmented Matrix : [A|B]
   AugmentedA = [A B]; 
   AugmentedA = [A,B];
   for i=1:n 
        [AugmentedA(i:n,i:n+1),err]=pivot(AugmentedA(i:n,i:n+1));
        if err == 0
            AugmentedA(1:n,i:n+1)=step(AugmentedA(1:n,i:n+1),i);
        end
   end
    x=AugmentedA(:,n+1);
    time = toc;
    executionTime = time;
 answer = x;
 fileID = fopen('output.txt','w');
for i=1:n
fprintf(fileID,'%6s%d',char(vars(i)));
fprintf(fileID,'=');
fprintf(fileID,'%f\n',double(answer(i)));
end
fclose(fileID);  
 
function [subMatrix,err]=pivot(A)
%This function swaps rows if pivot equals zero
[n,m]=size(A); 
subMatrix=A;
err = 0; % error flag
if subMatrix(1,1) == 0  % if the pivot element is zero we need to exchange rows
    check = logical(1); 
    i = 1;
    while check
        i = i + 1;
        if i > n  % reached the last row and no non-zero element is found
            err = 1;
            check = logical(0);
        else
            if A(i,1) ~= 0 & check
                check = logical(0);
                b=A(i,:);      %exchange rows 1 and i
                subMatrix(i,:)=subMatrix(1,:);
                subMatrix(1,:)=b;
            end
        end
    end
end
 
function subMatrix=step(A,i)

[n,m]=size(A);
subMatrix=A;
s=subMatrix(i,1);             
subMatrix(i,:) = A(i,:)/s;    %scaling
k=[[1:i-1],[i+1:n]];
for j=k
    s=subMatrix(j,1);
    subMatrix(j,:)=subMatrix(j,:)-subMatrix(i,:)*s;
end

