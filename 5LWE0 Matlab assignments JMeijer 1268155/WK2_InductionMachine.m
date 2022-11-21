%% WK2 - 5LWE0 - Induction machine
clear all; close all; clc;

Vmax = 230;     % [V] amplitude for the phase voltage
f = 50;         % [Hz] reference frequency
P = 2;          % [-] number of poles
w = 0;          % [rad/s] stator reference frame speed
rs = 2.0;       % [Ohm] stator resistance
rrd = 1.7;      % [Ohm] rotor resistance
Lm = 0.48;      % [H] magnetizing inductance
Lls = 8e-3;     % [H] stator leakage inductance
Llrd = 12e-3;   % [H] rotor leakage inductance
J = 6.8e-3;     % [kg*m^2] equivalent inertia
Pm = 3000;      % [W] rated mechanical power
Bm = Pm/(2845/60*(2*pi))^2;
La = ((1/Lm)+(1/Lls)+(1/Llrd))^-1;
Tload = 0;

if false
% Creating plot of simulation results
figure()
hold all
VelVect = zeros(10,10);     % Pre-allocate
TorqueVect = zeros(10,10);  % Pre-allocate
for i = 1:10
    f = 10*i;   % Changing reference frequency from 10 to 100 Hz
    
    for j = 1:10
        Tload = j-1;
        sim('WK2_InductionMachineSim.slx');     % Run simulation
        VelVect(i,j) = Velocity(end);
        TorqueVect(i,j) = Torque(end);
    end
    
    plot(VelVect(i,:),TorqueVect(i,:))
end

grid on
xlabel('Velocity [Hz]')
ylabel('Torque [Nm]')
title('Torque-speed characteristic of the IM')
legend('10 Hz','20 Hz','30 Hz','40 Hz','50 Hz','60 Hz','70 Hz','80 Hz','90 Hz','100 Hz','Location','Best')
end
