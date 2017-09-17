function [A,B] = pivot(A,B)
n = size(A,1);
for i = 1:n
    for j = i:n
        if (A(j,i) ~= 0)
            break;
        end
        
    end
    for k = 1:n
        t = A(i,k);
        A(i,k) = A(j,k);
        A(j,k) = t;  
    end
    t = B(i,1);
        B(i,1) = B(j,1);
        B(j,1) = t;
end
end