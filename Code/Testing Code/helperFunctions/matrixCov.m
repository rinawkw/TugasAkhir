function [Cov, LogCov] = matrixCov(Fn)
global g;
disp("matrix cov");
[a,b] = size(Fn);
for i=1:a
    Fn(i,:) = normalize(Fn(i,:),'range');
end
%disp(n);
Fnmean = mean(Fn,2);
Fnmin = Fn - Fnmean;
Cov = Fnmin * Fnmin.';
%disp(size(temp));

m = 1/b;
Cov = Cov * m;
LogCov = matrixLogCov(Cov);
test = reshape( LogCov, 1, []);
disp(test);
%train_walk = xlsread('training','walk');
%train_run = xlsread('training','run');
%label_walk=1*ones(size(train_walk,1),1);
%label_run=2*ones(size(train_run,1),1);
train = xlsread('weizmann_training_3.xlsx','ALL','A1:EN3124');
train_label = xlsread('weizmann_training_3.xlsx','ALL','EO1:EO3124');
%train_label = [1;2;3];
[ed,idx] = pdist2(train,test,'euclidean','Smallest',1);
disp(train_label(idx));
disp(ed);
g.done = 1;

%[predicted_labels,idx,accuracy] = KNN2(1,train,train_label,test,6);

%disp(predicted_labels, nn_index, accuracy);
