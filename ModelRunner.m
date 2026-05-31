
% Test case for PredatorPreyModel


params.r = 0.1;    % prey growth rate
params.a = 0.05;    % predation rate
params.m = 0.02;    % predator mortality rate
params.b = 0.0239;   % predator reproduction rate
inits.prey = .5;
inits.predator = 10;
tspan = [0 30000]; % Time span
funcs.C = @(x) 0.6452;   % constant prey addition
funcs.D = @(x) 0; % no predator addition

% you gotta use "@varible number operation varible" to define arbitrary functions in matlab
%there might be a better way but this is what I got


%run the actual funciton
data = PredatorPreyModel(params, funcs, tspan, inits);
