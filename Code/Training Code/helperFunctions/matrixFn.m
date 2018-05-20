function [Fn] = matrixFn(x,y,t,u,v,It,Ut,Vt,Div,Vor,Gten,Sten,Ftemp)
% row 1 = x
% row 2 = y
% row 3  = t
% row 4= u
% row 5 = v
% row 6 = It
    x_ = reshape( x, 1, []);
    y_ = reshape( y, 1, []);
    t_ = reshape(ones(144,180)*t,1,[]);
    u_ = reshape( u, 1, []);
    v_ = reshape( v, 1, []);
    It_ = reshape( It, 1, []);
    Ut_ = reshape( Ut, 1, []);
    Vt_ = reshape( Vt, 1, []);
    Div_ = reshape( Div, 1, []);
    Vor_ = reshape( Vor, 1, []);
    Gten_ = reshape( Gten, 1, []);
    Sten_ = reshape( Sten, 1, []);


    temp(1,:) = x_;
    temp(2,:) = y_;
    temp(3,:) = t_;
    temp(4,:) = u_;
    temp(5,:) = v_;
    temp(6,:) = It_;
    temp(7,:) = Ut_;
    temp(8,:) = Vt_;
    temp(9,:) = Div_;
    temp(10,:) = Vor_;
    temp(11,:) = Gten_;
    temp(12,:) = Sten_;
        
    Fn = [Ftemp temp];
    
    %A = rand(3,2177280);
%if size(Fn)==size(A)
  %disp(Fn);
%end