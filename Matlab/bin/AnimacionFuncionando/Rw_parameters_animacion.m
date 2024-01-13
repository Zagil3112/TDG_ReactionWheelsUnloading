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
T_max = 7.7501;% mNm

% Inercia RW 
% J = 4.32e-7; %[kg m2]
J = 7.613e-5; %[kg m2]
Iw = [J 0 0 ;
      0 J 0 ;
      0 0 J ]; 


%% Inercia EyasSat [kg m2] 
I =1e-7*[336109.715 0 0 ;
        0 308250.765 0; 
        0 0 271714.972];
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
n_cal = n_layers*turns_per_layer;

%%



