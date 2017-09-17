function [bound1 , bound2]= initialGuess(fh)


flag1=0;
flag2=0;
delta=0.1;
iterations=0;
x1=0;
x2=0;
bound1=0;
bound2=0;
while(flag1==0||flag2==0) 
    iterations=iterations+1;
    if(iterations>20)
        delta=delta*20;
    end
    x1=x1+delta;
    x2=x2-delta;
    if(fh(x1)>0&&flag1==0)
    bound1=x1;
    flag1=1;
    elseif(fh(x1)<0&&flag2==0)
     bound2=x1;
     flag2=1;
    end
    if(fh(x2)>0&&flag1==0)
      bound1=x2;
      flag1=1;  
    elseif(fh(x2)<0&&flag2==0)
      bound2=x2;
      flag2=1;  
    end

  
end

%   disp(bound1)
%   disp(bound2)

end