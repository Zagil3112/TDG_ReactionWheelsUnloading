t_final =15000;
simulation = sim('MagneticField');
Bx = simulation.B_NED.signals.values(:,1);
BY = simulation.B_NED.signals.values(:,2);
BZ = simulation.B_NED.signals.values(:,3);
