%% Params
t_sim = 20000;
plot_flag = false;
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
%% Plots

% RW Torques

groupPlots(t1, RW_torques1, t2, RW_torques2, t3, RW_torques3, t4, RW_torques4, "RW Z axis torques [Nm]");

% Yaw Error
groupPlots(t1, YawError1, t2, YawError2, t3, YawError3, t4, YawError4, "Yaw Error [rad]");









%% Performance Indices

showPerformanceIndices(LQR_PID_controller,"LQR_PID_controller");
showPerformanceIndices(PID_deltaH_controller,"PID_deltaH_controller");
showPerformanceIndices(LQR_I_controller,"LQR_I_controller");
showPerformanceIndices(LQR_deltaH_controller,"LQR_deltaH_controller");

%% Functions

function groupPlots(t1, param1, t2, param2, t3, param3, t4, param4,PlotTitle)
    figure()
    
    plot(t1,param1,'LineWidth', 3);
    hold on
    
    plot(t2,param2,'LineWidth', 2);
    hold on
    
    plot(t3,param3,'LineWidth', 3);
    hold on
    
    plot(t4,param4,'LineWidth', 1);
    hold on
    
    legend("LQR cascade PID","PID delta H","LQR cascade I","LQR delta H")
    
    title(PlotTitle)
    grid on
    hold off
end

function [t,YawError,RW_torques] = GetControllerPlots(ControllerObject,ControllerName)
   
    t = ControllerObject.Ref_Error.time;
    
    %Error de Referencia
    YawError = ControllerObject.Ref_Error.signals.values(:,1);
    if (plot_flag)
        figure()
        plot(t, YawError, 'LineWidth', 3)
        title(ControllerName+' Yaw Error [rad]')
        grid on
    end
    % RW Torques Z 
    RW_torques = ControllerObject.RW_torque.signals.values(:,3);
     if (plot_flag)
        figure()
        plot(t, RW_torques, 'LineWidth', 3)
        title(ControllerName+' RW Z torques [Nm]')
        grid on
     end
end

function showPerformanceIndices(ControllerObject,name)
    
    Error_ref = ControllerObject.performanceIndices.signals.values(end,1);
    Error_deltaH = ControllerObject.performanceIndices.signals.values(end,2);
    RW_power = ControllerObject.performanceIndices.signals.values(end,3);
    Mgt_power = ControllerObject.performanceIndices.signals.values(end,4);

    display("Performance Indices for "+name)
    display("Total: "+num2str(Error_ref+Error_deltaH+RW_power+Mgt_power))
    display(table(Error_ref,Error_deltaH,RW_power,Mgt_power))
end