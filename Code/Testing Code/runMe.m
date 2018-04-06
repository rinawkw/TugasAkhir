clear in;
clear global g;
global g;
t_idx = 1;
nofFrames = 1000;
while t_idx < nofFrames
    clear in;
    in.done = 0;
    in.label = 'run';
    in.method =  @FlowHS;
    in.bRecordFlow = 0;
    in.vidRes  = [128 128];
    in.targetFramerate = 24;
    in.movieType = 'denis_run.avi';
   
    in.startingTime = t_idx;
    in.endingTime  = t_idx + 19;
    if in.endingTime >= nofFrames
       in.endingTime = nofFrames;
       disp("yes")
    end
    vidProcessing(in);
    while g.t <= in.endingTime
         pause(0.001);
    end
    t_idx = t_idx + 20;
    nofFrames = g.nofFrames;
end
