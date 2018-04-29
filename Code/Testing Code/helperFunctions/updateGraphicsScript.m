function updateGraphicsScript(in,myHandles,curIm,varargin)
% Update the graphics, depending on the "method" used
disp("update image");
global g;
%only update if user has NOT killed figure:
if ~ishandle(myHandles.figH) || strcmpi(get(myHandles.figH,'BeingDeleted'),'on')
    return;
end

U = varargin{1};V = varargin{2};
It = varargin{3};

if g.bColorFlowDisp %then do color coding of flow, full resolution
    an  = (atan2(V,U)+ pi+0.000001)/(2*pi+0.00001);
    mag = min(0.99999999,sqrt(U.^2 + V.^2)*in.sc/10);
    set(myHandles.hImObj ,'cdata', hsv2rgb(an,  mag,   max(mag,curIm/256)));
    
else % if ~g.bColorFlowDisp
    set(myHandles.hImObj ,'cdata',curIm);
    set(myHandles.hQvObjPoints,'UData', in.sc*U, 'VData', in.sc*V);
    
end

if in.bRecordFlow
    if g.bColorFlowDisp
        if strcmpi(in.method,'user') || strcmpi(in.method,'synthetic')
            U = (U+in.rm)*(127/in.rm);
            V = (V+in.rm)*(127/in.rm);
            It = (It+in.rm)*(127/in.rm);
            writeVideo(g.writeVidFlow,...
               reshape(uint8([U, V, curIm]),...
               [size(an,1) size(an,2) 3]));
            if in.bDisplayGT
                fwrite(g.writeFlowGT,U_GT,'single');
                fwrite(g.writeFlowGT,V_GT,'single');               
            end
        else %saving non-flow method (only video)
            writeVideo(g.writeVidFlow,uint8(curIm));
        end
    else %if ~g.bColorFlowDisp
        writeVideo(g.writeVidFlow,uint8(curIm));
        fwrite(g.writeFlow,U,'single');
        fwrite(g.writeFlow,V,'single');
        if in.bDisplayGT
            fwrite(g.writeFlowGT,U_GT,'single');
            fwrite(g.writeFlowGT,V_GT,'single');               
        end      
    end
end


     if g.bUpdateText
        if g.bPause
            PausString = 'PAUSED(HIT "P")   ';
        else
            PausString = '';
        end
         
         if strcmpi(g.kindOfMovie, 'synthetic')
             set(g.figH, 'Name',[PausString '[q,a]Lag:' num2str(g.lagTime,'%1.2f') ',  [w,s]Speed:' num2str(g.spdFactor(1),'%2.1f')  ',  [e,d]Rotation:' num2str(g.spdFactor(2),'%2.1f') ',  [r,f]Gamma:'  num2str(g.gamma,'%2.2f') ]);
         else 
             set(g.figH, 'Name',[PausString '[q,a]Lag:' num2str(g.lagTime,'%1.2f') ',  [r,f]Gamma:'  num2str(g.gamma,'%2.2f') ]);
         end
     end



