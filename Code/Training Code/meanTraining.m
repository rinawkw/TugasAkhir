run_training = xlsread('weizmann_training.xlsx','RUN');
walk_training = xlsread('weizmann_training.xlsx','WALK');
wave2_training = xlsread('weizmann_training.xlsx','WAVE2');
run_mean = mean(run_training,1);
walk_mean = mean(walk_training,1);
wave2_mean = mean(wave2_training,1);
mean_training = [run_mean;walk_mean;wave2_mean];
xlswrite('weizmann_training_mean.xlsx',mean_training,'MEAN');