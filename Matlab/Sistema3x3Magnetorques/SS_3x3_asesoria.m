Tx =1.133e-7;
Ty= -2.83e-7;
Tz = 1.077e-5;

K= n_cal*A/R_mgt;

B = [5e-6 40e-6 1e-6];


Bx = B(1);
By = B(2);
Bz = B(3);


Vx = (Tx+K*Bx*(Ty-K*Bz))/(K*By)
Vy = Ty-K*Bz