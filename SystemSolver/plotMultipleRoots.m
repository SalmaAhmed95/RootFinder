function  plotMultipleRoots(graphAx,roots,index)
roots = roots(index,:);
disp(roots);
m = size(roots,2);
 
iter = [1:m];
    axes(graphAx.plotArea);
hold on
 
    %line([limX],[0 0], 'color', 'black'); % draw x-axis
    line(iter,roots','color','blue');
%     title(strcat('x',i+'0'));
%     xlabel('iterations');
%     ylabel('root');
%    
    grid on
    hold off
end