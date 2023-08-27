function F = fbnd(x)

B = [-30e-6 35e-6 0];
torques = [0 0 1.332e-5];

Bx = B(1);
By = B(2);
Bz = B(3);
K = 0.05667;
Tx = torques(1);
Ty = torques(2);
Tz = torques(3);

% F(1) = (x(1)+1)*(10-x(1))*(1+x(2)^2)/(1+x(2)^2+x(2));
% F(2) = (x(2)+2)*(20-x(2))*(1+x(1)^2)/(1+x(1)^2+x(1));

 F =  [0*x(1)+K*Bz*x(2)-K*By*x(3)-Tx;
          -K*Bz*x(1)+0*x(2)+K*Bx*x(3)-Ty;
          K*By*x(1)-K*Bx*x(2)+0*x(3)-Tz];
end
