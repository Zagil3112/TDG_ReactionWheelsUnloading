%% Params
t_sim = 80;
init_step=5;
end_step=40;

global plot_flag orbit_path profile;

plot_flag = false;
 
orbit_path="orbit_polar";
profile = "Nadir";
magnetic_field= B_mag90;

%B_mag51,B_mag90,B_mag0

%% Paths
LQR_PID_path = ".\Controladores\LQR\NonLinear\LQR_bloques_SS_LQR_cascada_PID_controller_NonLinear";
PID_deltaH_path = ".\Controladores\PID\PID_mgtXY_loadingTest";
LQR_I_path = ".\Controladores\LQR\NonLinear\LQR_bloques_SS_LQR_cascada_I_controller_NonLinear";
LQR_deltaH_path = ".\Controladores\LQR\NonLinear\LQR_bloques_SS_LQR_Delta_H_NonLinear";

%Controller Objects
%%
LQR_PID_controller = sim(LQR_PID_path);
%%
PID_deltaH_controller= sim(PID_deltaH_path);
%%
LQR_I_controller= sim(LQR_I_path);

%%
LQR_deltaH_controller= sim(LQR_deltaH_path);

%% LQR Cascade PID
[t1,YawError1,SC_omega1,RW_h1,RW_torques1,Mgt_torques1,Yaw1] = GetControllerPlots(LQR_PID_controller,"LQR PID controller");
%% PID delta H 
[t2,YawError2,SC_omega2,RW_h2,RW_torques2,Mgt_torques2,Yaw2] = GetControllerPlots(PID_deltaH_controller,"PID delta H controller");
%% LQR Cascade I
[t3,YawError3,SC_omega3,RW_h3,RW_torques3,Mgt_torques3,Yaw3] = GetControllerPlots(LQR_I_controller,"LQR I controller");
%% LQR Delta H 
[t4,YawError4,SC_omega4,RW_h4,RW_torques4,Mgt_torques4,Yaw4] = GetControllerPlots(LQR_deltaH_controller,"LQR delta H controller");
%% Plots

% Graficar omega, error de yaw y momoneto angular para los 4 controladores
figure()
subplot(1,3,1)
groupPlots(t1, Yaw1, t2, Yaw2, t3, Yaw3, t4, Yaw4, "Yaw [deg]","yaw");
% t_ss = [0, init_step, end_step,t_sim]; % Time points
% y_ss = [0, yaw_ref, yaw_ref*2,yaw_ref*2]; % Corresponding y-values
% stairs(t_ss, y_ss);


subplot(1,3,2)
groupPlots(t1, SC_omega1, t2, SC_omega2, t3, SC_omega3, t4, SC_omega4, "SC Omega [rad/s]","sc_omega");
yline(omega_zero)

subplot(1,3,3)
groupPlots(t1, RW_h1, t2, RW_h2, t3, RW_h3, t4, RW_h4, "RW Momento angular [Nms]","RW_h");
saveas(gcf,"./Resultados_imagenes/"+profile+'/'+orbit_path+'/'+'yaw_omega_h.fig')
    



%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% groupPlots(t1, SC_omega1, t2, SC_omega2, t3, SC_omega3, t4, SC_omega4, "SC Omega [rad/s]","sc_omega");
% groupPlots(t1, YawError1, t2, YawError2, t3, YawError3, t4, YawError4, "Yaw Error [rad]","yaw_error");
% groupPlots(t1, RW_h1, t2, RW_h2, t3, RW_h3, t4, RW_h4, "RW Momento angular [Nms]","RW_h");
% groupPlots(t1, RW_torques1, t2, RW_torques2, t3, RW_torques3, t4, RW_torques4, "RW Z axis torques [Nm]","RW_torques");
% groupPlots(t1, Mgt_torques1, t2, Mgt_torques2, t3, Mgt_torques3, t4, Mgt_torques4, "Mgt Z axis torques [Nm]","Mgt_torques");

% plots3by1(t1,YawError1,SC_omega1,RW_h1)
% plots3by1(t2,YawError2,SC_omega2,RW_h2)
% plots3by1(t3,YawError3,SC_omega3,RW_h3)
% plots3by1(t4,YawError4,SC_omega4,RW_h4)

%%
% plots1by3(t3,Yaw_ref3,RW_torques3,RW_h3)



%% Performance Indices

[Error_ref1,Error_deltaH1,RW1_power1,Mgt1_power1,Total1]= showPerformanceIndices(LQR_PID_controller,"LQR_PID_controller");
[Error_ref2,Error_deltaH2,RW1_power2,Mgt1_power2,Total2]=showPerformanceIndices(PID_deltaH_controller,"PID_deltaH_controller");
[Error_ref3,Error_deltaH3,RW1_power3,Mgt1_power3,Total3]=showPerformanceIndices(LQR_I_controller,"LQR_I_controller");
[Error_ref4,Error_deltaH4,RW1_power4,Mgt1_power4,Total4]=showPerformanceIndices(LQR_deltaH_controller,"LQR_deltaH_controller");


index_matrix = ["LQR_PID_controller",Error_ref1,Error_deltaH1,RW1_power1,Mgt1_power1,Total1;
                "PID_deltaH_controller",Error_ref2,Error_deltaH2,RW1_power2,Mgt1_power2,Total2;
                "LQR_I_controller",Error_ref3,Error_deltaH3,RW1_power3,Mgt1_power3,Total3;
                "LQR_deltaH_controller",Error_ref4,Error_deltaH4,RW1_power4,Mgt1_power4,Total4];

index_table = array2table(index_matrix,...
    'VariableNames',{'Controller','Error Ref','Error DeltaH','RW Power','Mgt Power','Total'});

display(index_table)
writetable(index_table,"./Resultados_imagenes/"+profile+'/'+orbit_path+'/'+orbit_path+'_table.txt','Delimiter',' ');

%% Functions

function plots3by1_allControllers()
    figure()
    subplot(1,3,1)
    groupPlots(t1, YawError1, t2, YawError2, t3, YawError3, t4, YawError4, "Yaw Error [rad]","yaw_error");
    
   
   
    subplot(1,3,2)
    groupPlots(t1, SC_omega1, t2, SC_omega2, t3, SC_omega3, t4, SC_omega4, "SC Omega [rad/s]","sc_omega");
    
    
    subplot(1,3,3)
    groupPlots(t1, RW_h1, t2, RW_h2, t3, RW_h3, t4, RW_h4, "RW Momento angular [Nms]","RW_h");
    saveas(gcf,"./Resultados_imagenes/"+profile+'/'+orbit_path+'/'+fileName+'_yaw_omega_h.fig')
    
end

function plots1by3(t,param1,param2,param3)
    figure()
    subplot(3,1,1)
    plot(t,param1(:,1),'LineWidth', 1);
    grid on
    hold on
    ylabel('Yaw[deg]')
    xlabel('tiempo [s]')
    title('Error Yaw [rad]')
    
    
    subplot(3,1,1)
    plot(t,param1(:,2),'g','LineWidth', 1);
    grid on
   
    title('Error Yaw [rad]')

    subplot(3,1,2)
    plot(t,param2,'LineWidth', 1);
    grid on
    ylabel('RW Torque [Nm]')
    xlabel('tiempo [s]')
    title('SC omega [rad/s]')
    
    subplot(3,1,3)
    plot(t,param3,'LineWidth', 1);
    grid on
    ylabel('RW H [Nms]')
    xlabel('tiempo [s]')
    title('RW Momento Angular [Nms]')

end


function groupPlots(t1, param1, t2, param2, t3, param3, t4, param4,PlotTitle,fileName)
    global orbit_path profile
    % figure()
    
    plot(t1,param1,'LineWidth', 1);
    hold on
    
    plot(t2,param2,'LineWidth', 1);
    hold on
    
    plot(t3,param3,'g','LineWidth', 1);
    hold on
    
    plot(t4,param4,'LineWidth', 1);
    hold on
    
    legend("LQR cascade PID","PID delta H","LQR cascade I","LQR delta H",Location="best")
    
    title(PlotTitle)
    ylabel(PlotTitle)
    xlabel("tiempo [s]")
    grid on
    hold on


    % % Apply the export setup
    % matlab.graphics.exportsetup.Format = 'png';
    % matlab.graphics.exportsetup.Width = '24cm';
    % matlab.graphics.exportsetup.Height = '10cm';
    % matlab.graphics.exportsetup.Resolution = '600'; 

    % saveas(gcf,"./Resultados_imagenes/"+profile+'/'+orbit_path+'/'+fileName+'.png')
    % saveas(gcf,"./Resultados_imagenes/"+profile+'/'+orbit_path+'/'+fileName+'.fig')
end

function [t,YawError,SC_omega,RW_h,RW_torques,Mgt_torques,Yaw] = GetControllerPlots(ControllerObject,ControllerName)
    global plot_flag
    t = ControllerObject.Ref_Error.time;
    
    %Error de Referencia
    YawError = ControllerObject.Ref_Error.signals.values(:,1);
    if (plot_flag)
        figure()
        plot(t, YawError, 'LineWidth', 3)
        title(ControllerName+' Yaw Error [rad]')
        grid on
    end
    
    %Yaw
    Yaw = ControllerObject.Yaw.signals.values(:,1);


    % RW Torques Z 
    RW_torques = ControllerObject.RW_torque.signals.values(:,3);
     if (plot_flag)
        figure()
        plot(t, RW_torques, 'LineWidth', 3)
        title(ControllerName+' RW Z torques [Nm]')
        grid on
     end
     % Velocidad angular SC
    SC_omega = ControllerObject.SC_omega.signals.values(:,3);
     if (plot_flag)
        figure()
        plot(t, SC_omega, 'LineWidth', 3)
        title(ControllerName+' SC omega [rad/s]')
        grid on
     end

     % Momento angular RW
    RW_h = ControllerObject.RW_h.signals.values(:,3);
     if (plot_flag)
        figure()
        plot(t, RW_h, 'LineWidth', 3)
        title(ControllerName+' RW H [Nms]')
        grid on
     end

    % Mgt Torques Z 
    Mgt_torques = ControllerObject.Mgt_torque.signals.values(:,3);
     if (plot_flag)
        figure()
        plot(t, Mgt_torques, 'LineWidth', 3)
        title(ControllerName+' RW Z torques [Nm]')
        grid on
     end

end

function [t,YawError,SC_omega,RW_h,RW_torques,Mgt_torques,Yaw_ref] = GetControllerPlots2(ControllerObject,ControllerName)
    global plot_flag
    t = ControllerObject.Ref_Error.time;
    
    %Yaw cal
    Yaw_cal = ControllerObject.Yaw_ref.signals.values(:,1);
      
    %Yaw ref
    Yaw_ref = ControllerObject.Yaw_ref.signals.values();

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
     % Velocidad angular SC
    SC_omega = ControllerObject.SC_omega.signals.values(:,3);
     if (plot_flag)
        figure()
        plot(t, SC_omega, 'LineWidth', 3)
        title(ControllerName+' SC omega [rad/s]')
        grid on
     end

     % Momento angular RW
    RW_h = ControllerObject.RW_h.signals.values(:,3);
     if (plot_flag)
        figure()
        plot(t, RW_h, 'LineWidth', 3)
        title(ControllerName+' RW H [Nms]')
        grid on
     end

    % Mgt Torques Z 
    Mgt_torques = ControllerObject.Mgt_torque.signals.values(:,3);
     if (plot_flag)
        figure()
        plot(t, Mgt_torques, 'LineWidth', 3)
        title(ControllerName+' RW Z torques [Nm]')
        grid on
     end

end


function [Error_ref,Error_deltaH,RW_power,Mgt_power,Total]= showPerformanceIndices(ControllerObject,name)
    
    Error_ref = ControllerObject.performanceIndices.signals.values(end,1);
    Error_deltaH = ControllerObject.performanceIndices.signals.values(end,2);
    RW_power = ControllerObject.performanceIndices.signals.values(end,3);
    Mgt_power = ControllerObject.performanceIndices.signals.values(end,4);
    Total = num2str(Error_ref+Error_deltaH+RW_power+Mgt_power);
    display("Performance Indices for "+name)
    display("Total: "+Total)
    display(table(Error_ref,Error_deltaH,RW_power,Mgt_power))
end