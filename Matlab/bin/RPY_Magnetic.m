function RPY_Magnetic = RPY_Magnetic(NEDMagnetic,RPY)

R = RPY(1);
P= RPY(2);
Y = RPY(3);



C_NED2ENU = [0 1 0;
             1 0 0
             0 0 -1];
C_RPY2ENU = [sin(Y)*cos(P) cos(R)*cos(Y)+sin(R)*sin(Y)*sin(P) -sin(R)*cos(Y)+cos(R)*sin(Y)*sin(P);
    cos(Y)*cos(P) -cos(R)*sin(Y)+sin(R)*cos(Y)*sin(P) sin(R)*sin(Y)+cos(R)*cos(Y)*sin(P);
    sin(P) -sin(R)*cos(P) -cos(R)*cos(P)];

C_ENU2RPY = C_RPY2ENU^-1; 

RPY_Magnetic = C_ENU2RPY*C_NED2ENU*NEDMagnetic; 


end