function onFrameUpdate(varargin)
global g;
in = g.in;
myHandles = g.myHandles;
g.t=g.t+1;
t = g.t;

%strcmpi(get(myHandles.figH,'BeingDeleted'),'on')

%first check if we should quit or pause:
if      g.bQuittingRequested || ...
        t > in.endingTime ||...
        ~ishandle(myHandles.figH) || ...
        strcmpi(get(myHandles.figH,'BeingDeleted'),'on')
    if ishandle(myHandles.figH) 
        close(myHandles.figH); 
    end
    if t > in.endingTime
        [g.Cov, g.LogCov] = matrixCov(g.Fn);
        fprintf(['endingTime=' num2str(in.endingTime) ' is reached. ']);
    end
    
    %pause(0.1);
    
    return;
elseif g.bPause
    stop(g.timer1);
end

%% Timer updating
% if different lag was requested, we have to handle it here:
period =  round(1000*g.lagTime + 1000/g.in.targetFramerate)/1000;
if period ~= get(g.timer1,'Period')
    stop(g.timer1);
    set(g.timer1,'Period',period, 'StartDelay', period);
    start(g.timer1);
end

%define previous image:
g.imPrev = g.imNew;    
%get new image:
g.imNew= generateFrame(g.vid, t,g.kindOfMovie);
%perform analysis and update graphics:
[g.U, g.V, g.It] = in.userDefMethod(in,g.imNew,g.imPrev,g.U, g.V);
updateGraphicsScript(in,myHandles,g.imNew,g.U,g.V,g.It);
[g.Fn] = matrixFn(g.matRow, g.matCol, t, g.U, g.V, g.It, g.Fn);
%disp (t);

drawnow %expose
% pause(0.01);

end
