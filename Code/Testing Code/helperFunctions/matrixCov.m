function [Cov, LogCov] = matrixCov(Fn)
disp("matrix cov");
[a,b] = size(Fn);
%disp(n);
Fnmean = mean(Fn,2);
Fnmin = Fn - Fnmean;
Cov = Fnmin * Fnmin.';
%disp(size(temp));

m = 1/b;
Cov = Cov * m;
LogCov = matrixLogCov(Cov);
test = reshape( LogCov, 1, []);
%train_walk = xlsread('training','walk');
%train_run = xlsread('training','run');
%label_walk=1*ones(size(train_walk,1),1);
%label_run=2*ones(size(train_run,1),1);
train = xlsread('training_mean.xlsx','MEAN_CCTV_3');
train_label = [1;1;1;1;1;1;2;2;2;2;2;2;3;3;3];
%train_label = [1;2;3];
[predicted_labels,nn_index,accuracy] = KNN_(1,train,train_label,test,3);

%disp(predicted_labels, nn_index, accuracy);
