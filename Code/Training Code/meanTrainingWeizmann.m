run = xlsread('weizmann_training_2.xlsx','RUN');
walk = xlsread('weizmann_training_2.xlsx','WALK');
wave2 = xlsread('weizmann_training_2.xlsx','WAVE2');
jump = xlsread('weizmann_training_2.xlsx','JUMP');
pjump = xlsread('weizmann_training_2.xlsx','PJUMP');
jack = xlsread('weizmann_training_2.xlsx','JACK');
side = xlsread('weizmann_training_2.xlsx','SIDE');
skip = xlsread('weizmann_training_2.xlsx','SKIP');
wave1 = xlsread('weizmann_training_2.xlsx','WAVE1');

run_ = mean(run,1);
walk_ = mean(walk,1);
wave2_ = mean(wave2,1);
jump_ = mean(jump,1);
pjump_ = mean(pjump,1);
jack_ = mean(jack,1);
side_ = mean(side,1);
skip_ = mean(skip,1);
wave1_ = mean(wave1,1);

mean_training = [run_;walk_;wave2_;jump_;pjump_;jack_;side_;skip_;wave1_];

xlswrite('training_mean.xlsx',mean_training,'WEIZMANN_2');