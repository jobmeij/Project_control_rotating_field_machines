%% DC machine parameters
clear all; close all; clc;

Va_max = 420;
ra = 2.56;
k_v = 1.11;
L_a = 43.8e-3;
J = 134e-3;
Bm = 5e-3;

Td = 3/16000;
s = tf('s');

omega_BW = 1000*2*pi;
Kp = omega_BW*L_a;
Ki = omega_BW*ra;
Ci = Kp + Ki/s;
Hel = 1/(L_a*s + ra);
% sisotool(exp(-Td*s)*Hel, Ci)
Ccurrent = tf([119.7 6996.5],[1 0]);

K_p_m = pi/4*J/Td;

Hm = 1/(J*s + Bm);
On = K_p_m + Ki/s;
Td = L_a/ra;
% sisotool(exp(-Td*3*s)*Hm, On);
Cspeed = tf([1.2 0.45],[1 0]);

w_m = 4000;
Pm = 5000;
Rf = 276;
Bm_init = Bm;
Va_max_init = Va_max;

%%
% TBD what is 100% load torque?
Tmax = k_v*(Va_max/ra) - Bm;  % maximum reachable armature current multiplied with torque constant 
if true
figure(1)
hold all
for j = 1:10    % Simulate for different input voltages
    
    Va_max = Va_max_init*(j/10);
    for i = 1:10    % Simulate for different load torques
        
        Bm = Bm_init + Tmax*(i/10)*0.01;
        
        sim('WK1L1_DCmachine_sim.slx')
        
        TorqueVect(i,1) = k_v * Current(end);
        SpeedVect(i,1) = Speed(end);
    end
    plot(SpeedVect,TorqueVect)
end

xlabel('Steady-state rotor speed [Hz]')
ylabel('Load torque [Nm]')
title({'Operating points DC machine with varying','input voltage (10-100%) and load torque'})
legend('10%','20%','30%','40%','50%','60%','70%','80%','90%','100%','Location','Best')
grid on
end

