function [LogCov] = matrixLogCov(Cov)

[V,D] = eig(Cov);
Ddiag = diag(D);
Dlog = log(Ddiag);
D = diag(Dlog);
LogCov = V*D*V.';