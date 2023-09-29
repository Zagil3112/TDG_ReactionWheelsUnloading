function [t,YawError,RW_torques] = GetControllerPlots(ControllerObject,ControllerName)
   
    t = ControllerObject.Ref_Error.time;
    
    %Error de Referencia
    YawError = ControllerObject.Ref_Error.signals.values(:,1);
    
    figure()
    plot(t, YawError, 'LineWidth', 3)
    title(ControllerName+' Yaw Error [rad]')
    grid on
    
    % RW Torques Z 
    RW_torques = ControllerObject.RW_torque.signals.values(:,3);
    
    figure()
    plot(t, RW_torques, 'LineWidth', 3)
    title(ControllerName+' RW Z torques [Nm]')
    grid on
end