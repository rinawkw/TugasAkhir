
train = xlsread('weizmann_training_3.xlsx','ALL','A1:EN3124');
train_label = xlsread('weizmann_training_3.xlsx','ALL','EO1:EO3124');
test = xlsread('weizmann_testing_3.xlsx','ALL','A1:EN698');
test_label = xlsread('weizmann_testing_3.xlsx','ALL','EO1:EO698');

mdl2 = fitcknn(train,train_label,'Distance','euclidean');
cvmdl2 = crossval(mdl2);
cvmdlloss2 = kfoldLoss(cvmdl2);
p_label = predict(mdl2,test);
C = confusionmat(test_label,p_label);
%disp(C);
%disp(trace(C)/size(test,1));
predicted_labels=zeros(size(test,1),1);
idx = knnsearch(train,test,'NSMethod','exhaustive');

mdl3 = ExhaustiveSearcher(train);
idxNN = knnsearch(mdl3,test,'K',2);

count=0;
for i=1:size(test_label,1)
    predicted_labels(i)=train_label(idxNN(i));
    %fprintf(['label= ' num2str(predicted_labels(i)) '\n']);
    if predicted_labels(i)==test_label(i)
        count=count+1;
    end
end
akurasi = count/size(test,1);
%fprintf(['akurasi= ' num2str(akurasi) '\n']);
%load fisheriris
%X = meas;
%Y = species;
X = xlsread('weizmann_all.xlsx','ALL3','A1:EN3822');
Y = xlsread('weizmann_all.xlsx','ALL3','EO1:EO3822');
mdl = fitcknn(X,Y,'Distance','euclidean');
cvmdl = crossval(mdl);
cvmdl_predict = kfoldPredict(cvmdl);
cvmdl_conf = confusionmat(cvmdl.Y,cvmdl_predict);
disp(cvmdl_conf);
cvmdlloss = kfoldLoss(cvmdl);
validationAccuracy = 1 - kfoldLoss(cvmdl, 'LossFun', 'ClassifError');
disp(validationAccuracy);