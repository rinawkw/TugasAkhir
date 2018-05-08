% Copyright: Stefan  M. Karlsson, Josef Bigun 2014
function [U, V, It, Ut, Vt, Div, Vor, Gten, Sten] = FlowHS(in, imNew, imPrev,U,V)
persistent kern dx dy dt ux uy ut vx vy vt

%regularization parameter
eta= single(10);

%maximum iterations:
MaxIts=in.MaxIterations;

if nargin<4
    %first time we call the function, we have no flow to initialize with
     U = zeros(size(imNew));
     V = zeros(size(imNew));
    dx = zeros(size(imNew),'single');
    dy = zeros(size(imNew),'single');
    dt = zeros(size(imNew),'single');
    ux = zeros(size(imNew),'single');
    uy = zeros(size(imNew),'single');
    ut = zeros(size(imNew),'single');
    vx = zeros(size(imNew),'single');
    vy = zeros(size(imNew),'single');
    vt = zeros(size(imNew),'single');
     
    %make the kernel, normalize it to EnR. A lower EnR pushes down the
    %magnitude of no texture regions faster. As the maximum nof iterations
    %go up, EnR should be set closer to 1.
    EnR = min(1,  0.92 + 0.1*MaxIts/100);
    kern=[1       sqrt(2) 1       ; ...
          sqrt(2) 0       sqrt(2) ; ...
          1       sqrt(2) 1      ];
    kern = single(EnR*kern/sum(kern(:))); 
end

Uprev = U;
Vprev = V;
% [dx, dy, dt] = grad3D(imNew,imPrev);
[dx, dy, dt] = grad3Drec(imNew,imPrev,0.5,dx,dy,dt);
Ix = dx;
Iy = dy;
It = dt;

% explicit algorithm from Horn and Schunks original paper:
for i=1:MaxIts
    uAvg=conv2(U,kern,'same');      
    vAvg=conv2(V,kern,'same');
    U = uAvg - dx.*(dx.*uAvg + dy.*vAvg  + dt)./(eta.^2 + dx.^2 +dy.^2);
    V = vAvg - dy.*(dx.*uAvg + dy.*vAvg  + dt)./(eta.^2 + dx.^2 +dy.^2);
end

[ux,uy,ut,vx,vy,vt] = derivativeUV(U,Uprev,V,Vprev,0.5,ux,uy,ut,vx,vy,vt);
Ux = ux;
Uy = uy;
Ut = ut;
Vx = vx;
Vy = vy;
Vt = vt;

Div = Ux + Vy;
Vor = Vx - Uy;

Gten = 0.5*(((Ux+Vy).*(Ux+Vy)) - ((Ux.*Ux) + (Uy.*Vx) + (Vx.*Uy) + (Vy.*Vy)));
Sten = 0.5*(((Ux+Vy).*(Ux+Vy)) - ((Ux.*Ux) + ((Uy+Vx).*(Uy+Vx)./4) + ((Uy+Vx).*(Uy+Vx)./4) + (Vy.*Vy)));
%disp(Gten);




