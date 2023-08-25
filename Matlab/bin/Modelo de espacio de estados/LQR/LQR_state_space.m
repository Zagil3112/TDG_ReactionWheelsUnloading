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

D_model = [zeros(3) zeros(3) zeros(3);
    zeros(3) zeros(3) zeros(3);
    zeros(3) zeros(3) zeros(3)];


%%


%Choose Q and R
scenario = 1;   %1 = cheap control
                %2 = expensive control
                %3 = ignore position

switch scenario
    case 1
        %Cheap control
        Q = eye(9);
        % Q(6,6) = 1000;
        R = [0.005];
        
    case 2
        %Expensive control
        Q = eye(9);
        % Q(5,5) = 1;
        % Q(4,4) = 1;
        % Q(6,6) = 1000;
        % R = eye(9)*5;
        % R(3,3) = 0.05
        R=0.000005;
        
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

%%
%Initial condition
t_final = 500;
x0 = zeros(9,1);
x0(1) =0;
x0(2) =0;
x0(3) = 0;

% x0(5) = sin((pi/4)/2);
x0(6) = -sin((pi/2)/2);


simulation = sim('SC_LQR_simple');

% extract data
% t = simulation.sim_X.time;
% 
% x1 = simulation.sim_X.signals.values(:,1);
% x2 = simulation.sim_X.signals.values(:,2);
% x3 = simulation.sim_X.signals.values(:,3);
% 
% x6 = simulation.sim_X.signals.values(:,6);
% 
% u1 = simulation.sim_U.signals.values(:,1);
% u2 = simulation.sim_U.signals.values(:,2);
% u3 = simulation.sim_U.signals.values(:,3);
% 
% % RW torque
% RW_torque = simulation.RW_torque.signals.values();
% 
% 
% % plot
% figure(1)
% subplot(3,1,1)
% plot(t, x1, 'LineWidth', 3)
% title(['Scenario ',num2str(scenario)])
% grid on
% legend('x_1')
% 
% subplot(3,1,2)
% plot(t, x2, 'LineWidth', 3)
% grid on
% legend('x_2')
% 
% subplot(3,1,3)
% plot(t, x3, 'LineWidth', 3)
% grid on
% legend('x_3')
% 
% % Torques
% figure(2)
% subplot(3,1,1)
% plot(t, u1, 'LineWidth', 3)
% title(['Scenario ',num2str(scenario)])
% grid on
% legend('u_1')
% 
% subplot(3,1,2)
% plot(t, u2, 'LineWidth', 3)
% grid on
% legend('u_2')
% 
% subplot(3,1,3)
% plot(t, u3, 'LineWidth', 3)
% grid on
% legend('u_3')
% 
% %
% figure(3)
% plot(t, x6, 'LineWidth', 3)
% title(['Scenario ',num2str(scenario)])
% grid on
% legend('x_6')
% 
% figure(4)
% title("RW torque")
% subplot(3,1,1)
% plot(t, RW_torque(:,1), 'LineWidth', 3)
% legend('TX')
% 
% 
% subplot(3,1,2)
% plot(t, RW_torque(:,2), 'LineWidth', 3)
% legend('TY')
% 
% 
% subplot(3,1,3)
% plot(t, RW_torque(:,3), 'LineWidth', 3)
% legend('TZ')