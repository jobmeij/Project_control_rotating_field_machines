%% 5LWE0 - FOCIM
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
Is = 6.3;       % [A] rated stator current (rms)
N = 2845;       % [rpm] rated mechanical speed
Bm = Pm/(N/60*(2*pi))^2;
% Lrd_est = 0.1;
% LM_est = 0.1;
Lrd = Lm + Llrd;
Lrd_est = Lrd;
LM_est = 0.9*Lrd_est;   % LM_est / Lrd_est is about 1
La = ((1/LM_est)+(1/Lls)+(1/Llrd))^-1;      % Check if Lm is correct! should be LM?!
refSpeed = 20;

% System transfer functions
s = tf('s');
Ls = Lm + Lls;
TfIM = tf([1],[(Ls-(LM_est^2/Lrd)) rs]);
% CurrentController = tf([133],[1 0]);      % unstable
% CurrentController = tf([11],[1 0]);     % kinda stable?? nope.
% CurrentController = 125*(s+4.341)/(s*(s+14.5));       % unstable
% CurrentController = tf([1],[1 1]);
CurrentController = tf([50],[1 0]);
OLcurrent = TfIM*CurrentController;
CLcurrent = OLcurrent/(1+OLcurrent);

TfSpeed = TfIM * tf([1],[J Bm]);
SpeedController = tf([0.166],[1 0]);
OLspeed = TfSpeed*SpeedController*CLcurrent;
CLspeed = OLspeed/(1+OLspeed);


