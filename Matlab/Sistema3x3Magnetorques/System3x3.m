
B = [5e-6 40e-6 1e-6];
torques = [-4.364e-6 2.834e-7 1.048e-5];

Bx = B(1);
By = B(2);
Bz = B(3);

Tx = torques(1);
Ty = torques(2);
Tz = torques(3);
% 
K= n_cal*A/R_mgt;
% K= 0.5;

% syms Vx Vy Vz
% eqn1 = 0*Vx + K*Bz*Vy -K*By*Vz == Tx;
% eqn2 = -K*Bz*Vx + 0*Vy +K*Bx*Vz == Ty;
% eqn3 = K*By*Vx -K*Bx*Vy +0*Vz == Tz;
% 
% [A,B] = equationsToMatrix([eqn1, eqn2, eqn3], [Vx, Vy, Vz]);

% A = [0 K*Bz -K*By;
%     -K*Bz 0 K*Bx;
%     K*By -K*Bx 0];
% B = torques;

% VoltagesXYZ = linsolve(A,B)

syms Vx Vy Vz
Y = vpasolve([0*Vx + K*Bz*Vy -K*By*Vz == Tx,-K*Bz*Vx + 0*Vy +K*Bx*Vz == Ty,K*By*Vx -K*Bx*Vy +0*Vz == Tz], [Vx,Vy,Vz])

% F = @(x) [0*x(1)+K*Bz*x(2)-K*By*x(3)-Tx;
%          -K*Bz*x(1)+0*x(2)+K*Bx*x(3)-Ty;
%          K*By*x(1)-K*Bx*x(2)+0*x(3)-Tz];
% 
% x0 = [0,0,0];
% options = optimoptions('fsolve','Display','iter','FunctionTolerance',1e-20,'OptimalityTolerance',1e-30);
% [x,fval] = fsolve(F,x0,options)

