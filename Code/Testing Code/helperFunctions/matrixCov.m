function [Cov, LogCov] = matrixCov(Fn)
disp("matrix cov");
Cov = zeros(size(6,6));
[m,n] = size(Fn);
%disp(n);
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
test = reshape( LogCov, 1, []);
%train_walk = xlsread('training','walk');
%train_run = xlsread('training','run');
%label_walk=1*ones(size(train_walk,1),1);
%label_run=2*ones(size(train_run,1),1);
train = xlsread('weizmann_training_mean.xlsx','MEAN_CCTV');
train_label = [1;1;1;1;1;1;2;2;2;2;2;2;3;3;3];

[predicted_labels,nn_index,accuracy] = KNN_(1,train,train_label,test,2);

%disp(predicted_labels, nn_index, accuracy);
