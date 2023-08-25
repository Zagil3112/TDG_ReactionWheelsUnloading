function RPY_Magnetic = MagneticNED2Body(NEDMagnetic,)

NEDMagnetic =1;

C_NED2ENU = [0 1 0;
             1 0 0
             0 0 -1];

BF_Magnetic = 1;
end