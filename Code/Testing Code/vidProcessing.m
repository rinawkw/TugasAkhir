function vidProcessing(in)

addpath('helperFunctions');
%matrixFn();
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
            pathToSave = [];
            return;
        end
    end
    g = [];
end

%setting label
g.label = in.label;
g.startingTime = 1;
g.done = 0;
%setting whatever
[g.in, g.vid] = ParseAndSetupScript(in);


%set first t
g.t=g.in.startingTime;

%generate first frame, imprev = get new image 
g.imPrev = generateFrame(g.vid, g.t, g.kindOfMovie);
%bcs first tim, new = prev
g.imNew = g.imPrev;

g.U_GT =0;g.V_GT =0; %this, GT aint used

%get first U V
[g.U, g.V, g.It] = g.in.userDefMethod(g.in,g.imNew,g.imPrev); %for 1st frame U V = 000~
%checkFlowOutput(g.U, g.V);%sanity check on flow

%setup graphic for the 1st time
[g.myHandles,g.pathToSave,Fn,g.matRow,g.matCol] = setupGraphicsScript(g.in,g.imNew,g.U,g.V);        

in = g.in;
myHandles = g.myHandles;

%first time get fitur
[g.U, g.V, g.It] = in.userDefMethod(in,g.imNew,g.imPrev,g.U, g.V);
%first frame update graphic
updateGraphicsScript(in,myHandles,g.imNew,g.U,g.V,g.U_GT,g.V_GT,g.It);
[Fn] = matrixFn(g.matRow, g.matCol, g.t, g.U, g.V, g.It, Fn);
g.Fn = Fn;
drawnow %expose
start(g.timer1); % this issss theee loooppp 

%A = rand(6,2177280);
%if g.t == 84 
    %if size(g.Fn)==size(A)
   %     disp('yes');
  %      Fn = g.Fn;
    %disp(g.Fn);
 %   end
%else
  %  disp('no');
 %   Fn = g.Fn;
%end
%Fn = g.Fn;
%disp(size(g.Fn));
%Fn = reshape(g.Fn,6,2177280);

%disp(g.);
%nofFrame = g.nofFrame;
%Fn = g.Fn;