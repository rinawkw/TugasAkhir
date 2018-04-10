function [Cov, LogCov] = matrixCov(Fn)
global g;
Cov = zeros(size(6,6));
[m,n] = size(Fn);
disp(n);
Fnmean = mean(Fn,2);
for i = 1:n
    temp = (Fn(:,i)-Fnmean)*(Fn(:,i)-Fnmean).';
    Cov = Cov + temp;
    %disp(i);
    %disp(temp);
end

%disp(size(temp));

Cov = Cov * 1/6;
LogCov = matrixLogCov(Cov);
%num = xlsread('training',sheet);

disp('done');
g.done = 1;
