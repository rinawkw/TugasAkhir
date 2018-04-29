function [LogCov] = matrixLogCov(Cov)
disp("log cov");
[V,D] = eig(Cov);
Ddiag = diag(D);
Dlog = log(Ddiag);
D = diag(Dlog);
LogCov = V*D*V.';