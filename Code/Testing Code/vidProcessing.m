function vidProcessing(in)

addpath('helperFunctions');
disp("vidproc");
global g; 
persistent bKillGlob

if isempty(bKillGlob)
    bKillGlob = false;
end

if ~isempty(g)
    if ~isfield(g,'bQuittingRequested') || ~isfield(g,'kindOfMovie')
        error('There is a global variable "g" that was no created by me (is it important?). Please type "clear global g" before you run me again.');
    end
    if ~g.bQuittingRequested
        if ~bKillGlob
            bKillGlob = true;
            warning('A previous session has not finished correctly. Data from that session is available in global variable g. Run me again, and I will kill this data');
            return;
        end
    end
    g = [];
end

%setting label
g.label = in.label;
%g.startingTime = 1;
g.done = 0;
%setting whatever
[g.in, g.vid] = ParseAndSetupScript(in);

%set first t
g.t=g.in.startingTime;
%g.endingFrame = in.endingFrame;
%generate first frame, imprev = get new image 
g.imPrev = generateFrame(g.vid, g.t, g.kindOfMovie);
%bcs first tim, new = prev
g.imNew = g.imPrev;

%get first U V
[g.U, g.V, g.It, g.Ut, g.Vt, g.Div, g.Vor, g.Gten, g.Sten] = g.in.userDefMethod(g.in,g.imNew,g.imPrev); %for 1st frame U V = 000~

%%-setup graphic for the 1st time
[g.myHandles,g.matRow,g.matCol] = setupGraphicsScript(g.in,g.imNew,g.U,g.V); 
in = g.in;
myHandles = g.myHandles;
Fn = [];
%first time get fitur
[g.U, g.V, g.It, g.Ut, g.Vt, g.Div, g.Vor, g.Gten, g.Sten] = in.userDefMethod(in,g.imNew,g.imPrev,g.U, g.V);

%first frame update graphic
updateGraphicsScript(in,myHandles,g.imNew,g.U,g.V,g.It);
[Fn] = matrixFn(g.matRow, g.matCol, g.t, g.U, g.V, g.It, g.Ut, g.Vt, g.Div, g.Vor, g.Gten, g.Sten, Fn);
g.Fn = Fn;
drawnow %expose
start(g.timer1); % this issss theee loooppp 