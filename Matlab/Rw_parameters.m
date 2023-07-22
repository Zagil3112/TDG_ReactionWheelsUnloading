
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
A =((1.45e-2)^2)*pi/4; % m^2
mu_0 = 1.25663706212e-6; %Vs/Am
mu_r = 200000; % Hierro http://hyperphysics.phy-astr.gsu.edu/hbase/Tables/magprop.html#c2
%L = 11.2534e-3; % H 
L = 0.585; % H 
l = 7.92e-2; % m 

n=sqrt(L*l/(mu_0*mu_r*A)); % https://en.universaldenker.org/formulas/459
T_max_mgt= -1.8432e-02; %mNm

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

s = tf('s');
voltaje = 9;

sys = ((Kt*(J*s+B))/(La*J*s^2+(Ra*J+La*B)*s+Ra*B+Kt*Ke));

