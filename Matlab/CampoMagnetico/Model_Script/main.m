%% ORBIT PARAMETERS
RAAN    =  75.84;                % Right Ascension of Ascendent Node [deg]
w       =  115.67;                % Argument of perigee               [deg]
v0      =  16.3;                % True anomaly at the departure     [deg]
i       =  98;             % inclination                       [deg]
a       =  6378+600;              % Major semi-axis           (>6378) [km]
e       =  0.0004681;             % Eccentricity
start_time = datetime('08-Sep-2023 12:45:07'); % UTC time of sattelite starting point
norb = 4;                     % number of orbits
time_step =1;               % Calculate point every time_step   [s],
                              %   decrease for faster calculation

%% CALCULATION
[lla, time] = orbit_calc(RAAN, w, v0, i, a, e, start_time, norb, ...
    time_step);

%  B   Column vectors of Magnetic field vector     [nT]
%  H   Horizontal component of Magnetic field  B   [nT]
%  D   Magnetic field Declination                  [deg]
%  I   Magnetic field Inclanation                  [deg]
%  F   Magnetic field Intensity                    [nT] 
[B_mag, H_mag, D_mag, I_mag, F_mag] = b_calc(lla, time);
B_mag = B_mag*1e-9;

saveVariable(B_mag,"Orbit_0_degrees.txt")
% %% PLOTTING
% subplot(3,1,1)
% plot(F_mag);
% title('F - Magnetic field Intensity ')
% xlabel('point num') 
% ylabel('[nT]') 
% 
% subplot(3,1,2)
% plot(D_mag);
% title('D - Magnetic field Declination')
% xlabel('point num') 
% ylabel('[deg]')  
% 
% subplot(3,1,3)
% plot(I_mag);
% title('I - Magnetic field Inclanation')
% xlabel('point num') 
% ylabel('[deg]') 