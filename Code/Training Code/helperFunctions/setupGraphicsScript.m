function [myHandles, pathToSave, Fn, matRow, matCol] = setupGraphicsScript(in,imNew, varargin)
global g;
pathToSave = in.pathToSave;
myHandles.figH = figure('NumberTitle','off');
g.bColorFlowDisp =1;
%A = rand(3,1);
%g.Fn = zeros(size(A));
%% Setup row & col matrix
row = reshape( 1:360, 360, []);
matRow = row*ones(1,636);
col = reshape(1:636,[],636);
matCol = ones(360,1)*col;
%matFrame = ones(144,180);
Fn = [];
g.matFn = [];

%set(myHandles.figH, 'Name', func2str(in.userDefMethod));
U = varargin{1};
if all(size(imNew) == size(U)) %then display as color coding
    g.bColorFlowDisp = 1;
    if in.bDisplayGT
      subplot(1,2,1);
    end
    myHandles.hImObj = image(zeros([size(imNew), 3]));
    axis off;axis image; title(gca, ... 
      [func2str(in.userDefMethod) ', color-coded flow image']);
    if in.bDisplayGT
      subplot(1,2,2);
      myHandles.hImObjGT = image(zeros([size(imNew), 3]));          
      axis off;axis image; title(gca, 'Ground Truth Flow');
    end
else %if flow field not the size of image, display as vectors
    g.bColorFlowDisp = 0;
    myHandles.hImObj= imagesc( imNew,[0,250]);
    colormap gray;axis off;axis manual;axis image;
    hold on;

    oldSize = size(imNew);  
    newSize = size(U);
    scale = newSize./oldSize;    
    iY = min(round(((1:newSize(1))-0.5)./scale(1)+0.5),oldSize(1));
    iX = min(round(((1:newSize(2))-0.5)./scale(2)+0.5),oldSize(2));

    if in.bDisplayGT
      myHandles.hQvObjLines  = quiver(iX,iY, zeros(size(U)),  zeros(size(U)),0 ,'m','MaxHeadSize',5,'Color',[.9 .2 .1]);%, 'LineWidth', 1);
      title(gca,[func2str(in.userDefMethod) ', scaled by ' num2str(in.sc) ':1, blue: estimation, red: ground truth' ]);              
    else
      title(gca,[func2str(in.userDefMethod) ', scaled by ' num2str(in.sc) ':1' ]);              
    end
    myHandles.hQvObjPoints = quiver(iX,iY, zeros(size(U)),  zeros(size(U)),0 ,'m','MaxHeadSize',0.1,'Color',[0 1 .1]);%, 'LineWidth', 1);
    axis image;axis manual;
end
      
in.bColorFlowDisp = g.bColorFlowDisp;
if in.bRecordFlow
        if strcmp(in.pathToSave,'')
          saveNum =1;
          while exist(['savedOutput' num2str(saveNum)],'dir')
            saveNum = saveNum+1;
          end
          pathToSave = ['savedOutput' num2str(saveNum)];
        else
            pathToSave = in.pathToSave;
        end
        if ~exist(pathToSave,'dir'), mkdir(pathToSave);end 
        
        if g.bColorFlowDisp %then save as color video file (also true for non-flow methods, such as "gradient") 
        g.writeVidFlow = VideoWriter(fullfile(pathToSave, 'tmp.avi'),'Archival');
        g.writeVidFlow.FrameRate = min(in.targetFramerate,30);
        open(g.writeVidFlow);
    	save(fullfile(pathToSave, 'flow.mat'),'in');

        else 
            g.writeVidFlow = VideoWriter(fullfile(pathToSave, 'flow'),'Archival');
            g.writeVidFlow.FrameRate = min(in.targetFramerate,30);
            open(g.writeVidFlow);
            save(fullfile(pathToSave, 'flow.mat'),'in', 'iX','iY');
            g.writeFlow = fopen(fullfile(pathToSave, 'flow.bin'),'w');
        end
       if in.bDisplayGT
        g.writeFlowGT = fopen(fullfile(pathToSave, 'flowGT.bin'),'w');
       end        
end


g.figH = myHandles.figH;
%setup keyboard callback
set(myHandles.figH, 'WindowKeyPressFcn',@myKeypress,...
    'WindowKeyReleaseFcn', @myKeyrelease,'CloseRequestFcn',@onStop,...
    'Interruptible','off', 'busyAction','cancel',...
    'handlevisibility','off');
% g.figTopText = get(myHandles.figH,'Name');
% set(hImObj , 'ButtonDownFcn',@MouseButtonDownFcnIm);


if strcmpi(in.movieType, 'synthetic')
    set(myHandles.figH, 'Name',[get(myHandles.figH, 'Name') ' -- (shut down figure to stop), keys (q,a,w,s,e,d,p) for lag time and pattern speed --' ]);
else
    set(myHandles.figH, 'Name',[get(myHandles.figH, 'Name') ' -- shut down figure to stop']);
end
