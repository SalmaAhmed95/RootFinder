function writeOutput(fileName,header,A,time,bound)
fid = fopen(fileName,'wt');
spaces= 8;
 for i = 1:length(header)
[~,c]=size(header(i));
%disp(c);
spaces=max(spaces,c);
%disp(spaces);
for j=1:spaces-length(header{i})
fprintf(fid,' ');
%disp('.');
end
 
fprintf(fid,'%s',header{i});
fprintf(fid,'\t');
end
fprintf(fid,'\n');
for i = 1:size(A,1)
fprintf(fid,'%f\t',A(i,:));
fprintf(fid,'\n');
end
for j=1:spaces-4
fprintf(fid,' ');
%disp('.');
end
fprintf(fid,'time\t%f',time);
for j=1:spaces-5
fprintf(fid,' ');
%disp('.');
end
fprintf(fid,'bound\t%f',bound);
end