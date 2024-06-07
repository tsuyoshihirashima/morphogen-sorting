function prm = GetParameters() %

prm.XMAX=20; % domain size/cell number in x axis, default: 20
prm.YMAX=15; % domain size/cell number in y axis, default: 15
prm.CELL_NUMB = prm.XMAX * prm.YMAX;

prm.MCS_TIME = 100; % Monte-Carlo Simulation time
prm.STEP_MAX = (prm.MCS_TIME+1) * prm.XMAX * prm.YMAX;

%% Cadherin dynamics
prm.TAU =  0.1;

%% Cadherin strength
prm.CAD = 100;

prm.CADMODE = 1; % 0: linear regime, 1: saturated regime

%% Noise (aberrant) cells
prm.NOISE = 0; % 0: no noise, 1: shot noise + insensitive, 2: sensitive 
prm.NFACTOR = 10;

end