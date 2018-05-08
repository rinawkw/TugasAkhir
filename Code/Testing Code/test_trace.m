Fn = [1 5 3 6 5 6 4 6 7 5; 
     3 4 5 5 4 5 4 4 3 4;
     4 2 5 7 3 3 7 2 3 2;
     6 7 8 3 5 3 9 3 1 1]
%disp (trace(A));
Cov = zeros(size(4,4));
Cov2 = zeros(size(4,4));
[m,n] = size(Fn);
%disp(n);
Fnmean = mean(Fn,2);
Fnmin = Fn - Fnmean;
for i = 1:n
    temp = (Fn(:,i)-Fnmean)*(Fn(:,i)-Fnmean).';
    Cov = Cov + temp;
end
Cov2 = Fnmin * Fnmin.';
Cov = Cov * 1/6;
Cov2 = Cov2 * 1/6;
disp (Cov);
disp (Cov2);