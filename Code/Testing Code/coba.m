
%A(:,:,2) = [1 0 4; 3 5 6; 9 8 7];

%t_ = ones(8,1)*A;
%[E,index] = sortrows(A);
%train_label = xlsread('weizmann_training_2.xlsx','ALL','EO1:EO3876');
%disp(size(t_,2));
rng('default') % For reproducibility
A = [1 2; 2 8]; %testing
B = [ 1 4; 2 1; 1 8]; %training
%disp(A);
%disp(B);
[D,I] = pdist2(B,A,'euclidean','Smallest',1)
%S = pdist2(B,A)
disp(D);
%C = A-B;
%disp(C);
%sqrt(sum(C.^2,2))