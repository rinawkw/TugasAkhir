function [myHandles, matRow, matCol] = setupGraphicsScript(in,imNew, varargin)
global g;
disp("setupgraphic");

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

g.matFn = [];

%set(myHandles.figH, 'Name', func2str(in.userDefMethod));
U = varargin{1};
if all(size(imNew) == size(U)) %then display as color coding
    g.bColorFlowDisp = 1;
    
    myHandles.hImObj = image(zeros([size(imNew), 3]));
    axis off;axis image; title(gca, ... 
    [func2str(in.userDefMethod) ', color-coded flow image']);
    
else %if flow field not the size of image, display as vectors
    g.bColorFlowDisp = 1;
    myHandles.hImObj= imagesc( imNew,[0,250]);
    colormap gray;axis off;axis manual;axis image;
    hold on;

    oldSize = size(imNew);  
    newSize = size(U);
    scale = newSize./oldSize;    
    iY = min(round(((1:newSize(1))-0.5)./scale(1)+0.5),oldSize(1));
    iX = min(round(((1:newSize(2))-0.5)./scale(2)+0.5),oldSize(2));

    title(gca,[func2str(in.userDefMethod) ', scaled by ' num2str(in.sc) ':1' ]);              
    
    myHandles.hQvObjPoints = quiver(iX,iY, zeros(size(U)),  zeros(size(U)),0 ,'m','MaxHeadSize',0.1,'Color',[0 1 .1]);%, 'LineWidth', 1);
    axis image;axis manual;
end
      
in.bColorFlowDisp = g.bColorFlowDisp;

g.figH = myHandles.figH;
%setup keyboard callback
set(myHandles.figH, 'WindowKeyPressFcn',@myKeypress,...
    'WindowKeyReleaseFcn', @myKeyrelease,'CloseRequestFcn',@onStop,...
    'Interruptible','off', 'busyAction','cancel',...
    'handlevisibility','off');
% g.figTopText = get(myHandles.figH,'Name');
% set(hImObj , 'ButtonDownFcn',@MouseButtonDownFcnIm);

set(myHandles.figH, 'Name',[get(myHandles.figH, 'Name') ' Testing - shut down figure to stop']);

