% Clears up memory
% persistent variables in functions:

function cleanUpScript(~,~)
global g;
if ~g.bQuittingRequested
    return;
end
delete(g.figH);
g.bQuittingRequested = 1;
in = g.in;
vid = g.vid;

if strcmpi(g.kindOfMovie,'file')
    delete(vid);   
elseif strcmpi(g.kindOfMovie,'camera')
  if vid.bUseCam ==2
      vi_stop_device(vid.camIn, vid.camID-1);
      vi_delete(vid.camIn);
  else
      pause(0.2)
      stop(vid.camIn);
      delete(vid.camIn); 
  end
end 

