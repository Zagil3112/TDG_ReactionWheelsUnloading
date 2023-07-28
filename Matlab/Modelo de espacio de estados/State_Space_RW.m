% Reaction Wheels
La = 0.222e-3  ; %H 
Ra = 3.36; % Omh
%Kt = 8.8e-3*(60/(2*pi));
Kt = 8.55e-3; % Nm/A

% B = 8.85e-6*(60/(2*pi));  
B =(1/438)*(60/(2*pi))*1e-3; % Nm/rad/s
% Ke = 0.922e-3*(60/(2*pi)); 
Ke = (1/1120)*(60/(2*pi));  % V/rad/s

T_ext = 6.850e-7;% Nm
T_max = 7.7501e-3;% Nm

RW_omega_max = 3940*((2*pi)/60); % rad/s
% RW_omega_max = 1000*((2*pi)/60); % rad/s

% Inercia RW 
J_rotor = 4.32e-7; %[kg m2]
J_flywheel = 7.1137e-5; %[kg m2]
J = J_rotor+ J_flywheel; %[kg m2]

A_motor = [-B/J Kt/J;
         -Ke/La -Ra/La];
B_motor = [0; 1/La];

C_motor = [1 0];

D_motor = 0;

motor =ss(A_motor,B_motor,C_motor,D_motor,...
    'InputName','v','OutputName','y','StateName',{'w','v'});

amp = tf(5,[1/1000 1]);
plant=motor*amp;
plant.StateName{3} = 'x3';
pole(plant);
isstable(plant);
step(plant);
ctrb_matrix = ctrb(plant);
rank(ctrb_matrix);

% controller

plant.c =eye(3);
plant.StateName{3} = 'x3';
plant.OutputName = {'w','i','x3'};
plant

K = place(plant.a, plant.b, [-7 +5.25j, -7 -5.25j , -21]);
