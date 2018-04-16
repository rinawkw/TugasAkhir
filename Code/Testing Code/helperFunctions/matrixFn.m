function [Fn] = matrixFn(x,y,t,u,v,It,Ftemp)
% row 1 = x
% row 2 = y
% row 3  = t
% row 4= u
% row 5 = v
% row 6 = It
    x_ = reshape( x, 1, []);
    y_ = reshape( y, 1, []);
    t_ = reshape(ones(720,1280)*t,1,[]);
    u_ = reshape( u, 1, []);
    v_ = reshape( v, 1, []);
    It_ = reshape( It, 1, []);

    temp(1,:) = x_;
    temp(2,:) = y_;
    temp(3,:) = t_;
    temp(4,:) = u_;
    temp(5,:) = v_;
    temp(6,:) = It_;
        
    Fn = [Ftemp temp];
    
    %A = rand(3,2177280);
%if size(Fn)==size(A)
  %disp(Fn);
%end