%% Params
t_sim = 20000;

%% Paths
LQR_PID_path = ".\Controladores\LQR\NonLinear\LQR_bloques_SS_LQR_cascada_PID_controller_NonLinear";
PID_deltaH_path = ".\Controladores\PID\PID_mgtXY_loadingTest";
LQR_I_path = ".\Controladores\LQR\NonLinear\LQR_bloques_SS_LQR_cascada_I_controller_NonLinear";
LQR_deltaH_path = ".\Controladores\LQR\NonLinear\LQR_bloques_SS_LQR_Delta_H_NonLinear";

%Controller Objects

LQR_PID_controller = sim(LQR_PID_path);
PID_deltaH_controller= sim(PID_deltaH_path);
LQR_I_controller= sim(LQR_I_path);
LQR_deltaH_controller= sim(LQR_deltaH_path);

%% LQR Cascade PID
[t1,YawError1,RW_torques1] = GetControllerPlots(LQR_PID_controller,"LQR PID controller");
%% PID delta H 
[t2,YawError2,RW_torques2] = GetControllerPlots(PID_deltaH_controller,"PID delta H controller");
%% LQR Cascade I
[t3,YawError3,RW_torques3] = GetControllerPlots(LQR_I_controller,"LQR I controller");
%% LQR Delta H 
[t4,YawError4,RW_torques4] = GetControllerPlots(LQR_deltaH_controller,"LQR delta H controller");
%%














%%
% RW_torqueX = simulation.RW_torque.signals.values(:,1);
% RW_torqueZ = simulation.RW_torque.signals.values(:,3);
% 
% figure(1)
% % subplot(3,1,1)
% plot(t, RW_torqueZ, 'LineWidth', 3)
% title('RW_torqueZ ')
% grid on
% legend('RW_Z')
% % x2 = simulation.sim_X.signals.values(:,2);
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