%% LAB preparation for rotating field machines 
clear all; close all; clc;

s = tf('s');

% General parameters
J = 27.6 * 10^-3;
b1 = 15.1*10^-4;
b0 = 0.47;
Fsample = 16000;
Tsample = 1/Fsample;

% DC Machines 
if true
   % Siemens GG5104 machine
   Rf = 276;
   Lf = 58.4;
   Ra = 1.93;
   La = 10.8 *10^-3;
   If_max = 0.8;
   Vf_max = 310;
   Ia_max = 14.8;
   Va_max = 420;
   Pmech = 5.15 * 10^3;    
else
    % Creusen 112L-4GM machine
    Rf = 561;
    Lf = 60.7;
    Ra = 1.05;
    La = 4.3 * 10^-3;
    If_max = 0.48;
    Vf_max = 340;
    Ia_max = 16.4;
    Va_max = 400;
    Pmech = 5.5 * 10^3;    
end

% Induction machine
if false
    % Siemens
    Lm = 0.3744;
    Lls = 7.88 * 10^-3;
    Rs = 1.75;
    Llr = 11.82 * 10^-3;
    Rr = 1.54;
    Iph_max = 6.3;
    Vph_max = 230;
    omega_rm = 2845;
    Pmech = 3.45 * 10^3;
else
    % SEW
    Lm = 0.628;
    Lls = 7.882 * 10^-3;
    Rs = 1.72;
    Llr = 11.82 * 10^-3;
    Rr = 1.868;
    Iph_max = 5.5;
    Vph_max = 230;
    omega_rm = 2850;
    Pmech = 3 * 10^3;
end

% Current controller DC (torque control)

% Speed controller DC (not needed)

% Current controller IM
Ls = Lm + Lls;
Lrd = Lm + Llr;
Lsd = Ls - Lm^2/Lrd;
omega_c = 200; % TBD
tau_e = Lsd/Rs;
Ki = omega_c*Rs;
Kp = tau_e*Ki;
ImCurrentTf = tf([1],[Lsd Rs])

% Created controller with PM = 60 deg, fco = 200 rad/s
% ImCurrentController = 1760.1 * ((s+116.4)/(s*(s+438.7)));
ImCurrentController = Kp * tf([Ki],[1 0])
DtImCurrentController = c2d(ImCurrentController,Tsample);
sisotool(ImCurrentTf,ImCurrentController);

% Speed controller IM
ImSpeedTf = tf([1],[J b1])
Bm = b1;
tau_m = J/Bm;
omega_cm = 2; % TBD
K_im = omega_cm*Bm;
K_pm = tau_m*K_im;
% Created speed controller with PM = 60deg, fco = 12.5 rad/s
%ImSpeedController = 8.71 * ((s+0.05713)/(s*(s+21.62)));
ImSpeedController = K_pm * tf([K_im],[1 0])
DtImSpeedController = c2d(ImSpeedController,Tsample);
sisotool(ImSpeedTf,ImSpeedController);

% abc->dq & dq->abc: see Simulink

