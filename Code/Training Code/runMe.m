global g;
%clear in;
%clear global g;
[~,filename] = xlsread('filename_training.xlsx','test3');
%i=1;

for i=1:3
    disp(i);
    %j=1;
    row=1;
    for j=1:7
        clear in;
        in.t_idx = 1;
        nofFrames = 1000;
        in.file = char(filename(j+1,i));
        disp(in.file);                                                                                                                                                                                                                                                                                                                                                                                                                                 
        if strcmp(in.file,'none')
           disp("continue");
           continue
        end
        in.endingTime=20;
        while in.t_idx < nofFrames
            in.label = char(filename(1,i));
            in.method =  @FlowHS;
            in.bRecordFlow = 0;
            in.movieType = in.file;
            in.startingTime = in.t_idx;
            in.row=row;
            in.endingTime  = in.t_idx + 19;
            in.vidRes  = [128 128];
            in.targetFramerate = 24;
            vidProcessing(in);
            in.t_idx = in.t_idx + 1;
            nofFrames = g.nofFrames;
            while g.t <= in.endingTime || g.save <=0 || g.done <=0
                %disp("pause");
                 pause(0.01);
            end
            row = row+1;
        end
        pause(0.1);
        %j=j+1;
    end
    pause(0.1);
    %i=i+1;
end

