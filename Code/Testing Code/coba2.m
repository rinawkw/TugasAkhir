
%A(:,:,2) = [1 0 4; 3 5 6; 9 8 7];

%t_ = ones(8,1)*A;
%[E,index] = sortrows(A);
train = xlsread('weizmann_training_all.xlsx','ALL','A1:EN3876');
train_label = xlsread('weizmann_training_all.xlsx','ALL','EO1:EO3876');
test = xlsread('weizmann_testing_2.xlsx','WAVE1','A1:EN112');
test_label = xlsread('weizmann_testing_2.xlsx','WAVE1','EO1:EO112');
%train_label = [1;2;3];

[ed,idx] = pdist2(train,test,'euclidean','Smallest',1);
%disp(train_label(idx));
predicted_labels=zeros(size(test,1),1);
for i=1:size(test_label,1)
    predicted_labels(i)=train_label(idx(i));
end
%calculate the classification accuracy
if isempty(test_label)==0
    accuracy=length(find(predicted_labels==test_label))/size(test,1);
    g.done = 1;
end
fprintf([' accuracy=' num2str(accuracy) '\n']);
%train_label = xlsread('weizmann_training_2.xlsx','ALL','EO1:EO3876');
%disp(size(t_,2));
%rng('default') % For reproducibility
%A = [1 2]; %testing
%B = [ 1 4; 2 1; 1 8]; %training
%disp(A);
%disp(B);
%[D,I] = pdist2(train,test,'euclidean','Smallest',3)
%S = pdist2(B,A)
%disp(D);
%C = A-B;
%disp(C);
%sqrt(sum(C.^2,2))