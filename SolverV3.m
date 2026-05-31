
% We set our chosen targets
TargetPrey =  1;      
TargetPredator = 15;  

% These are the pre-existing conditions of the system that will remain fixed
r = 0.1; % prey growth rate    
a = 0.05;  % predation rate
m = 0.02;  % predator mortality rate
D = 0;      % D is set to zero for all cases from the paper, but it could theroticaly be set to somehting else.
tspan = [0 30]; %
inits = [5; 10]; 

% Here we make our starting guesses for the parmaters
initial_C = 10;  
initial_b = 0.1; 
parameter_guess = [initial_C, initial_b];


% We use fminsearch to find the optimal parameters that minimize the error between the final populations and our targets.

%displaying the optimaztion
options = optimset('Display', 'iter', 'TolFun', 1e-9); 

%here we create a function for calculating the error between the final populations and our targets.
%this is what fminsearch will use, the importat thing to note here is that, we are not passing in a fixed
%answer, rather the ability for fm
cost_func = @(p) CalculateError(p, r, a, m, D, tspan, inits, TargetPrey, TargetPredator);

%This is where the optimization actually happens
%fminsearch will call the cost_func with different values of C and b, and it will try to find the values that minimize the error.
%it will continue to call the cost_func with different values until it finds the optimal parameters that minimize the error.
optimal_params = fminsearch(cost_func, parameter_guess, options);

%here we get out final paramers and make our graphs
final_C = optimal_params(1);
final_b = optimal_params(2);

%printing
fprintf('\nSuccess! Parameters found:\n');
fprintf('Optimized C:      %.4f\n', final_C);
fprintf('Optimized b:      %.4f\n', final_b);

% Run final model
odefun = @(t, y) GetDerivatives(t, y, r, a, m, final_b, final_C, D);
[T, Y] = ode23(odefun, tspan, inits);

% Plotting
figure('Name', 'Optimized C and b', 'Color', 'w');
subplot(2,1,1);
plot(T, Y(:,1), 'b', 'LineWidth', 1.5); hold on;
plot(T, Y(:,2), 'r', 'LineWidth', 1.5);
yline(TargetPrey, 'b--', 'Target Prey');
yline(TargetPredator, 'r--', 'Target Predator');
xlabel('Time'); ylabel('Population');
legend('Prey', 'Predator', 'Target Prey', 'Target Predator');
title(['Optimized: C=' num2str(final_C,'%.2f') ' & b=' num2str(final_b,'%.3f')]);
grid on;
subplot(2,1,2);
plot(Y(:,1), Y(:,2), 'k', 'LineWidth', 1.2); hold on;
plot(TargetPrey, TargetPredator, 'go', 'MarkerFaceColor', 'g', 'MarkerSize', 8); 
xlabel('Prey'); ylabel('Predator');
title('Phase Space (Green Dot = Target)');
grid on;




%this function creates our error calculation. 
function error = CalculateError(params, r, a, m, D, tspan, inits, targetP, targetV)
    C_try = params(1); 
    b_try = params(2); 
    %make the odefun with the new parameters
    odefun = @(t, y) GetDerivatives(t, y, r, a, m, b_try, C_try, D);
    
    try %Run the ODE solver
        [~, Y] = ode23(odefun, tspan, inits);
        final_prey = Y(end, 1);
        final_predator = Y(end, 2);
        
        error = (final_prey - targetP)^2 + (final_predator - targetV)^2;
    catch %we need the try and catch here becouse the function might become too big very fast, so if that happens
          %just give it a really big number, so that fminsearch will know to avoid that area of the parameter space.
        error = 1e6; 
    end
end


% This function creates the actual differential equations of the system.
function dydt = GetDerivatives(~, y, r, a, m, b, C, D)
    C_val = C; 
    
    D_val = D;

    dydt = [
        r * y(1) - a * y(1) * y(2) + C_val; 
        b * y(1) * y(2) - m * y(2) + D_val
    ];
end