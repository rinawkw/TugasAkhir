%run_training = xlsread('weizmann_training.xlsx','RUN');
%walk_training = xlsread('weizmann_training.xlsx','WALK');
%wave2_training = xlsread('weizmann_training.xlsx','WAVE2');
%walk_rina_training = xlsread('weizmann_training.xlsx','WALK_RINA');
%run_rina_training = xlsread('weizmann_training.xlsx','RUN_RINA');
run1 = xlsread('cctv_training_3.xlsx','RUN1');
run2 = xlsread('cctv_training_3.xlsx','RUN2');
run3 = xlsread('cctv_training_3.xlsx','RUN3');
run4 = xlsread('cctv_training_3.xlsx','RUN4');
run5 = xlsread('cctv_training_3.xlsx','RUN5');
run6 = xlsread('cctv_training_3.xlsx','RUN6');
walk1 = xlsread('cctv_training_3.xlsx','WALK1');
walk2 = xlsread('cctv_training_3.xlsx','WALK2');
walk3 = xlsread('cctv_training_3.xlsx','WALK3');
walk4 = xlsread('cctv_training_3.xlsx','WALK4');
walk5 = xlsread('cctv_training_3.xlsx','WALK5');
walk6 = xlsread('cctv_training_3.xlsx','WALK6');
wave1 = xlsread('cctv_training_3.xlsx','WAVE1');
wave2 = xlsread('cctv_training_3.xlsx','WAVE2');
wave4 = xlsread('cctv_training_3.xlsx','WAVE4');
%run_mean = mean(run_training,1);
%walk_mean = mean(walk_training,1);
%wave2_mean = mean(wave2_training,1);
%walk_rina_mean = mean(walk_rina_training,1);
%run_rina_mean = mean(run_rina_training,1);

run1_ = mean(run1,1);
run2_ = mean(run2,1);
run3_ = mean(run3,1);
run4_ = mean(run4,1);
run5_ = mean(run5,1);
run6_ = mean(run6,1);

walk1_ = mean(walk1,1);
walk2_ = mean(walk2,1);
walk3_ = mean(walk3,1);
walk4_ = mean(walk4,1);
walk5_ = mean(walk5,1);
walk6_ = mean(walk6,1);

wave1_ = mean(wave1,1);
wave2_ = mean(wave2,1);
wave4_ = mean(wave4,1);

mean_training = [run1_;run2_;run3_;run4_;run5_;run6_;walk1_;walk2_;walk3_;walk4_;walk5_;walk6_;wave1_;wave2_;wave4_];

xlswrite('training_mean.xlsx',mean_training,'MEAN_CCTV_3');