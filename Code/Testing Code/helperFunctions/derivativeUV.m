function [ux,uy,ut,vx,vy,vt] = derivativeUV(U,Uprev,V,Vprev,tInt,ux,uy,ut,vx,vy,vt)
% global g;
gg = [0.2163,   0.5674,   0.2163];
% tInt(in interval [0,1]) indicates temporal integration

tInt=0.5;

fU = U + Uprev;
ux = tInt*ux + (1-tInt)*conv2(fU(:,[2:end end ]) - fU(:,[1 1:(end-1)]),gg','same');
uy = tInt*uy + (1-tInt)*conv2(fU([2:end end],: ) - fU([1 1:(end-1)],:),gg ,'same');
ut = tInt*ut + (1-tInt)*2*conv2(gg,gg,U - Uprev,'same');
fV = V + Vprev;
vx = tInt*vx + (1-tInt)*conv2(fV(:,[2:end end ]) - fV(:,[1 1:(end-1)]),gg','same');
vy = tInt*vy + (1-tInt)*conv2(fV([2:end end],: ) - fV([1 1:(end-1)],:),gg ,'same');
vt = tInt*vt + (1-tInt)*2*conv2(gg,gg,V - Vprev,'same'); 

