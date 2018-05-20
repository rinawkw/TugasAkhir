%
clear in;
%clear global g;
%global g;
%t_idx = 1;
%nofFrames = 1000;
%%-setup graphic for the 1st time
%[in.myHandles,in.dlesmatRow,in.matCol] = setupGraphicsScript(g.in,g.imNew,g.U,g.V); 
%while t_idx < nofFrames
    clear in;
    in.done = 0;
    in.label = 'run';
    in.method =  @FlowHS;
    in.bRecordFlow = 0;
    in.vidRes  = [128 128];
    in.targetFramerate = 25;
    in.movieType = 'lyova_walk.avi';
   
    in.startingTime = 1;
    %in.endingFrame  = t_idx + 19;
    in.endingTime = 'eof';
   % if in.endingFrame >= nofFrames
       %in.endingTime = nofFrames;
       %disp("yes")
     %  break
   % end
    vidProcessing(in);
    %while g.t <= in.endingFrame || g.done <=0
    %     pause(0.01);
    %end
    %t_idx = t_idx + 20;
    %nofFrames = g.nofFrames;
%end
%