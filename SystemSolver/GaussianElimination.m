function [answer,time] = GaussianElimination(A,B,vars)
  %solves systems of linear equations using Naive Gaussian Elimination
  
  %A is coefficients matrix : Ax=b
  
  %vector to hold the results
  tic;
  var = [];
  dimensions = size(A);
  if (dimensions(1)~=dimensions(2))
    error('coefficients matrix must be a square matrix');
  end
   if(det(A) ~= 0)
       [A,B] = pivot(A,B);
   end
   %forward substitution
   n = dimensions(1);
   for k = 1 : n-1
      for i = k+1 : n
          factor = A(i,k)/A(k,k);
          for j = k+1 : n
              A(i,j) = A(i,j) - (factor * A(k,j));
          end
          B(i) = B(i) - (factor * B(k));
      end
   end
   %disp(B);
   %disp("passed")
   %forward substitution checked
  
  %back Substitution
  var(n) = B(n)/A(n,n);  
 for i  = n-1 : -1 : 1   %inverse loop syntax
    sum =0;
    for j = i+1 :n
      sum = sum + (A(i,j) * var(j));
    end 
    var(i) = (B(i)-sum)/A(i,i);
 
 end
 fileID = fopen('output.txt','w');
for i=1:n
fprintf(fileID,'%6s%d',char(vars(i)));
fprintf(fileID,'=');
fprintf(fileID,'%f\n',var(i));
end
fclose(fileID);  
 answer = var';
 time = toc;