clear in;
clear global g;

%in.label = 'run';
%in.method =  @FlowHS;
%in.bRecordFlow = 0;
%in.endingTime  = 'eof';
%in.movieType = 'ido_run.avi';
%in.vidRes  = [128 128];
%in.targetFramerate = 24;
%vidProcessing(in);

t_idx = 1;
global g;
while 1
    clear in;
    in.done = 0;
    in.label = 'run';
    in.method =  @FlowHS;
    in.bRecordFlow = 0;
    in.movieType = 'ido_run.avi';
    in.startingTime = t_idx;
    in.endingTime  = t_idx + 19;
        in.vidRes  = [128 128];
    in.targetFramerate = 24;
    vidProcessing(in);
    t_idx = t_idx + 1; 
    if in.endingTime >= g.nofFrames
       break 
    end
    while g.t <= in.endingTime || g.done < 1
         pause(0.001);
    end
end
