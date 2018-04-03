t_idx = 1;
%nofFrames = 1000;
global g;
while 1
    clear in;
    %clear g;
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
    while g.t <= in.endingTime
         pause(0.001);
    end
end


%in.bAutoPlayWithPlayer = 0;
% [u,v] = vidProcessing(in);
%matFn = [];
%matFn=g.Fn;

%disp(g.Fn);


%Fn = reshape( 1:4, 2, 2);
%Fn(1,:) = 1:10;
%Fn = reshape( Fn, 1, []);
%col = [2 4 ; 4 5];
%Fn(1,:) = [Fn col];
%B = reshape( 1:144, 144, []);
%C = B*ones(1,180);
%C_ = reshape( C, 1, []);
%D = reshape(1:180,[],180);
%E = ones(144,1)*D;
%E_ = reshape( E, 1, []);
%C = reshape(C, 1, []);
%A = (size(B));
%t_ = reshape(ones(144,180)*3,1,[]);

%disp(Fn);

