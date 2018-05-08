function [Cov, LogCov] = matrixCov(Fn)
global g;
%disp(n);
[a,b] = size(Fn);
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
