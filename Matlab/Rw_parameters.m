La = 0.48  ; %H 
Ra = 7; % Omh
Kt = 8.8e-3*(60/(2*pi));  
Iw = 3e-6*[1 0 0 ; 0 1 0; 0 0 1]; %kg m2
B = 8.85e-6*(60/(2*pi));  
Ke = 0.922e-3*(60/(2*pi)); 
T_ext = 6.850e-7;% Nm

I =(4*0.3^2/6)*[1 0 0 ; 0 1 0; 0 0 1];%kg m2 - Inercia EyasSat 

A =((1.45e-2)^2)*pi/4;
mu_0 = 1.25663706212e-12; %Vs/Am
mu_r = 200000; % Hierro http://hyperphysics.phy-astr.gsu.edu/hbase/Tables/magprop.html#c2
L = 11.2534e-3; % H 
%L = 0.585; % H 
l = 7.92e-2; % m 

n=sqrt(L*l/(mu_0*mu_r*A));