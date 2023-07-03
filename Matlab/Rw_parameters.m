La = 0.48  ; %H 
Ra = 7; % Omh
Kt = 8.8e-3*(60/(2*pi));  

B = 8.85e-6*(60/(2*pi));  
Ke = 0.922e-3*(60/(2*pi)); 
T_ext = 6.850e-7;% Nm

% Inercia EyasSat [kg m2] 
I =1e-7*[336109.715 0 0 ;
        0 308250.765 0; 
        0 0 271714.972];

% Inercia RW [kg m2]
Iw = 1e-5*[8.2738 0 0 ;
           0 7.5354 0 ;
           0 0 7.613 ]; 

A =((1.45e-2)^2)*pi/4;
mu_0 = 1.25663706212e-12; %Vs/Am
mu_r = 200000; % Hierro http://hyperphysics.phy-astr.gsu.edu/hbase/Tables/magprop.html#c2
L = 11.2534e-3; % H 
%L = 0.585; % H 
l = 7.92e-2; % m 

n=sqrt(L*l/(mu_0*mu_r*A));
