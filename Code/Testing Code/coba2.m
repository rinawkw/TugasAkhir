
%A(:,:,2) = [1 0 4; 3 5 6; 9 8 7];

%t_ = ones(8,1)*A;
%[E,index] = sortrows(A);
train = xlsread('weizmann_training_3.xlsx','ALL','A1:EN3124');
train_label = xlsread('weizmann_training_3.xlsx','ALL','EO1:EO3124');
test = xlsread('weizmann_testing_3.xlsx','WALK','A1:EN90');
test_label = xlsread('weizmann_testing_3.xlsx','WALK','EO1:EO90');
%train_label = [1;2;3];
X = xlsread('weizmann_all.xlsx','ALL3','A1:EN3822');
Y = xlsread('weizmann_all.xlsx','ALL3','EO1:EO3822');
mdl = fitcknn(X,Y);
cvmdl = crossval(mdl);
cvmdlloss = kfoldLoss(cvmdl);
classError = kfoldLoss(cvmdl);
%disp(a);
k = 1;
%[idx2,ed2] = knnsearch(train,test,'Distance',chiSqrDist,'k',k);
[ed,idx] = pdist2(train,test,'euclidean','Smallest',1);
%disp(train_label(idx));
predicted_labels=zeros(size(test,1),1);
count=0;
for i=1:size(test_label,1)
    predicted_labels(i)=train_label(idx(i));
    %fprintf([' ed=' num2str(ed2(i)) '\n']);
    if predicted_labels(i)==test_label(i)
        count=count+1;
    end
end
akurasi = count/size(test,1);
%calculate the classification accuracy
if isempty(test_label)==0
    accuracy=length(find(predicted_labels==test_label))/size(test,1);
    g.done = 1;
end
fprintf([' accuracy=' num2str(accuracy) '-' num2str(akurasi) '\n']);
disp(mdl);
disp(cvmdl);
disp(cvmdlloss);
disp(classError);
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