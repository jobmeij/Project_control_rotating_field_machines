%% 5LWE0 - FOCIM LAB simulation
clear all; close all; clc;

Fs = 16000;
Ts = 1/Fs;  

Vmax = 230;     % [V] amplitude for the phase voltage
f = 50;         % [Hz] reference frequency
P = 2;          % [-] number of poles
w = 0;          % [rad/s] stator reference frame speed
rs = 1.72;       % [Ohm] stator resistance
rrd = 1.868;      % [Ohm] rotor resistance
Lm = 0.628;     % [H] magnetizing inductance
Lls = 7.822*10^-3;     % [H] stator leakage inductance
Llrd = 11.82e-3;   % [H] rotor leakage inductance
J = 27.6e-3;     % [kg*m^2] equivalent inertia
%Bm = 5e-4;      % [Nms/rad] friction torque coefficient
Pm = 3000;      % [W] rated mechanical power
Is = 6.3;       % [A] rated stator current (rms)
N = 2845;       % [rpm] rated mechanical speed
Bm = 15.1e-4;

La = ((1/Lm)+(1/Lls)+(1/Llrd))^-1;

Ki = 133;
tau_e = 0;

% System transfer functions
Ls = Lm + Lls;
Lrd = Lm + Llrd;
TfIM = tf([1],[(Ls-(Lm^2/Lrd)) rs]);
dTfIM = c2d(TfIM,Ts);
CurrentController = tf([133],[1 0]);

TfSpeed = TfIM * tf([1],[J Bm]);
dTfSpeed = c2d(TfSpeed,Ts);
SpeedController = tf([0.166],[1 0]);


