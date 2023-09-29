
%Reaction Wheels
La = 0.222e-3  ; %H 
Ra = 3.36; % Omh
%Kt = 8.8e-3*(60/(2*pi));
Kt = 8.55e-3; % Nm/A

% B = 8.85e-6*(60/(2*pi));  
B =(1/438)*(60/(2*pi))*1e-3; % Nm/rad/s
% Ke = 0.922e-3*(60/(2*pi)); 
Ke = (1/1120)*(60/(2*pi));  % V/rad/s


T_max = 6.27e-3;% Nm
% T_max = 0.5e-3;% Nm
RW_omega_max = 3940*((2*pi)/60); % rad/s
%RW_omega_max = 1000*((2*pi)/60); % rad/s

% Inercia RW 
J_rotor = 4.32e-7; %[kg m2]
J_flywheel = 7.1137e-5; %[kg m2]
J = J_rotor+ J_flywheel; %[kg m2]


%% Inercia EyasSat [kg m2] 
I =1e-7*[336109.715 0 0 ;
        0 308250.765 0; 
        0 0 271714.972];

%% Orbit elements and Constants
R_earth = (6370 + 500)*1e3 ; %altitud [m]
mu_earth = 3.986e14; % Earth s gravitational parameter [m^3/s^2]
M = 7.96e15; % Earth’s magnetic moment [T*m^3]
B_earth = 2*M/R_earth^3;
rho_atm = 1.7e-11; % densidad del aire [kg/m^3]
M_earth = 5.97e24; % kg
G = 6.67e-11; % Constante gravitacional
SC_vel = sqrt(G*M_earth/R_earth); % [m/s]
F_aero = 0.5*rho_atm*(SC_vel^2)*2.5*(0.192*0.192);
pSR = 1353/3e8; 
FSR = pSR*(1+0.6)*(0.192*0.192);

%% Torques Externos
T_grav = (3*mu_earth/(2*R_earth^3))*abs(I(3,3)-I(2,2)); % Gradiente gravitacional [Nm]
T_mag = (0.01)*B; % Torque magnético [Nm]
T_aero =F_aero*0.05; 
T_solar = FSR*0.05;
% T_ext = 6.850e-7;% Nm
T_ext =(T_grav+T_mag+T_aero+T_solar);% Nm
%%  Magnetorquers
A =((2e-2)^2)*pi/4; % m^2
mu_0 = 1.25663706212e-6; %Vs/Am
mu_r = 200000; % Hierro http://hyperphysics.phy-astr.gsu.edu/hbase/Tables/magprop.html#c2
%L = 11.2534e-3; % H 
L = 0.585; % H 
l = 7.92e-2; % m 
R_mgt = 30 ;% Resistencia mgt [Ohm];
n=sqrt(L*l/(mu_0*mu_r*A)); % https://en.universaldenker.org/formulas/459
T_max_mgt= 1.8432e-05; %Nm

%% Coil
%dia_coil = 1.45 ;% cm
dia_coil = 2 ;% cm
dia_core= 0.77; % cm
dia_wire = 0.03; % cm
coil_longitude = 7.92; %cm
n_layers= (dia_coil-dia_core)/(2*dia_wire);
turns_per_layer = coil_longitude/dia_wire;
n_cal = n_layers*turns_per_layer; % # vueltas segun geometría 

%%

% s = tf('s');
% voltaje = 9;
% 
% sys = ((Kt*(J*s+B))/(La*J*s^2+(Ra*J+La*B)*s+Ra*B+Kt*Ke));
%%
Error_ref_Gain = 700/9;
DeltaH_error_Gain =3300*4*10000; 
RW_power_Gain =5;
Mgt_power_Gain = 0.1;

%%


% velocidad angular 
% w1 = realp('w1',0);
% w2 = realp('w2',0);
% w3 = realp('w3',0);

omega_model = [0 0 0];


% I11 = realp('I11', 0);
% I12 = realp('I12', 0);
% I13 = realp('I13', 0);
% 
% I21 = realp('I21', 0);
% I22 = realp('I22', 0);
% I23 = realp('I23', 0);
% 
% I31 = realp('I31', 0);
% I32 = realp('I32', 0);
% I33 = realp('I33', 0);
% matriz de inercia SC

I =1e-7*[336109.715 0 0 ;
        0 308250.765 0; 
        0 0 271714.972];

% Momentos angulares 

h1 = realp('h1', 0);
h2 = realp('h2', 0);
h3 = realp('h3', 0);

L_model = [0 0 0];

% Matrices de espacio de estados


Aww = skew(I*omega_model')-skew(omega_model')*I+skew(L_model');
Awh = -skew(omega_model');


A11 = (I^-1)*Aww;
A13 =(I^-1)*Awh;

A_model = [A11 zeros(3) A13;
    0.5*eye(3) zeros(3) zeros(3);
    zeros(3) zeros(3) zeros(3)];

B_model = [I^-1 I^-1 I^-1;
    zeros(3) zeros(3) zeros(3);
    eye(3) zeros(3) zeros(3)];

C_model = [eye(3) zeros(3) zeros(3);
    zeros(3) eye(3) zeros(3);
    zeros(3) zeros(3) eye(3)];

C_model2 = [zeros(3) zeros(3) zeros(3);
    zeros(3) eye(3) zeros(3);
    zeros(3) zeros(3) zeros(3)];

D_model = [zeros(3) zeros(3) zeros(3);
    zeros(3) zeros(3) zeros(3);
    zeros(3) zeros(3) zeros(3)];



%% LQR (u :  RW y Mgt ; ud: T_p)
B_model2 = [I^-1 I^-1;
    zeros(3) zeros(3) ;
    eye(3) zeros(3) ];

Gamma= [I^-1 zeros(3) zeros(3)]';

%% LQR (u :  RW ; ud: Mgt y T_p)
% B_model3 = [I^-1;
%     zeros(3)  ;
%     eye(3) ];
% 
% Gamma2= [I^-1 I^-1;
%     zeros(3) zeros(3);
%     zeros(3) zeros(3)];

%%


%Choose Q and R
scenario = 2;   %1 = cheap control
                %2 = expensive control
                %3 = ignore position

switch scenario
    case 1
        
        Q = eye(9);
        % Q(6,6) = 1000;
        R = [0.005];
        
    case 2
        Q = eye(9);
        % Q(6,6) = 1000;
        R = [0.05];     
     
        
    case 3
        %Only penalize the velocity state
        Q = diag([0.001 10]);
        R = [1];

    case 4
        %Funcional 
        Q = eye(9);
        R = [500];
        
    otherwise
        error('Unknown method')
end

% LQR (u = RW, Mgt y Tp)
[K,S,P] = lqr(A_model,B_model,Q,R);


disp('K computed via LQR:')
K

% Sub matrices 
disp('K1:')
K1 = K(1:3,:)

disp('K2:')
K2 = K(4:6,:)

disp('K3:')
K3 = K(7:9,:)



%Initial condition for LQR
t_final = 500;
x0 = zeros(9,1);
x0(1) =0;
x0(2) =0;
x0(3) = 0;

% x0(5) = sin((pi/4)/2);
x0(6) = -sin((pi/3)/2);

%%

A_motor = [-B/J Kt/J;
         -Ke/La -Ra/La];
B_motor = [0; 1/La];

C_motor = [0 Kt];

D_motor = 0;

%%

% LQR (u = RW y Mgt, ud = Tp)
[K_gamma,S2,P2] = lqr(A_model,B_model2,Q,R);

disp('K gamma computed via LQR:')
K_gamma

% Sub matrices 
disp('K1_2:')
K1_2 = K_gamma(1:3,:)

disp('K2_2:')
K2_2 = K_gamma(4:6,:)

disp('K gamma computed via LQR:')
K_gamma
disp('K3 gamma computed via LQR:')
K3_2 = K_gamma(:,4:6)

disp('K4 gamma computed via LQR:')
K4_2 = K_gamma(:,1:3)

%%

% % LQR (u = RW; ud = Mgt y Tp)
% [K_gamma2,S3,P3] = lqr(A_model,B_model3,Q,R);
% 
% disp('K gamma 2 computed via LQR:')
% K_gamma2

%%

% Specify the file name (change 'input.txt' to your file's name)
fileName = 'Orbit_51_degrees.txt';
fileName0 = 'Orbit_0_degrees.txt';
fileName90 = 'Orbit_90_degrees.txt';

% Call the readTxtFile function to read data from the file
B_mag51 = readTxtFile(fileName);
B_mag0 = readTxtFile(fileName0);
B_mag90 = readTxtFile(fileName90);



