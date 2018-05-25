function [Cov, LogCov] = matrixCov(Fn)
global g;
%disp(n);
[a,b] = size(Fn);
for i=1:a
    Fn(i,:) = normalize(Fn(i,:),'range');
end
Fnmean = mean(Fn,2);
Fnmin = Fn - Fnmean;
Cov = Fnmin * Fnmin.';

%disp(size(temp));
m = 1/b;
Cov = Cov * m;
LogCov = matrixLogCov(Cov);
%num = xlsread('training',sheet);
%disp(m);
%disp(n);
%disp('done');
g.done = 1;
