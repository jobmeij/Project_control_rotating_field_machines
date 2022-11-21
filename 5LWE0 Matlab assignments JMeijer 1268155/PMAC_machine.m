%% 5LWE0 - PMAC motor simulation

w_m_nom = 60000*2*pi/60;    % nominal rotor speed [rad/s]
% w_e = wrm_nom;
Vmax = 24;                  % Peak voltage [V]

Lls = 0.0072e-3;            % Leakage inductance [H]
Lm = 0.0648e-3;             % Magnetizing inductance [H]
Lq = Lls + Lm;              % Stator inductance [H]
Ld = Lq;                    % Stator inductance [H]

r_s = 1.3;                  % Stator resistance [Ohm]

P_l = 30;                   % Load power [W]
Bm = P_l/w_m_nom^2;        % Load coefficient [Nm s/rad]

J = 2.55e-8;                % Inertia [kg*m^2]
lambda_m = 3.49e-3;         % PM flux linkage [Wb turns]
P = 2;                      % Number of poles

f = 60000;
omega = f*2*pi;

T_load = 0;


