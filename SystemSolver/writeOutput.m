function writeOutput(fileName,header,A)
fid = fopen(fileName,'wt');
spaces= 8;
 for i = 1:size(header,1)
[~,c]=size(header(i,:));
%disp(c);
spaces=max(spaces,c);
%disp(spaces);
for j=1:spaces-size(header(i,:),2)
fprintf(fid,' ');
%disp('.');
end

fprintf(fid,'%s',header(i,:));
fprintf(fid,'\t');
end
fprintf(fid,'\n');
for i = 1:size(A,1)
fprintf(fid,'%f\t',A(i,:));
fprintf(fid,'\n');
end
end