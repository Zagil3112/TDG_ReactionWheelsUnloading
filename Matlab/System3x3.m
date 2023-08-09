
B = [5e-6 40e-6 1e-6];
torques = [-4.364e-6 2.834e-7 1.048e-5];

Bx = B(1);
By = B(2);
Bz = B(3);

Tx = torques(1);
Ty = torques(2);
Tz = torques(3);


syms Vx Vy Vz
eqn1 = 0*Vx + K*Bz*Vy -K*By*Vz == Tx;
eqn2 = -K*Bz*Vx + 0*Vy +K*Bx*Vz == Ty;
eqn3 = K*By*Vx -K*Bx*Vy +0*Vz == Tz;

[A,B] = equationsToMatrix([eqn1, eqn2, eqn3], [Vx, Vy, Vz]);

% A = [0 K*Bz -K*By;
%     -K*Bz 0 K*Bx;
%     K*By -K*Bx 0];
% B = torques;

VoltagesXYZ = linsolve(A,B)
