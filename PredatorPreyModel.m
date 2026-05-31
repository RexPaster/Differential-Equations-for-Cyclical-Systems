function data = PredatorPreyModel(params, funcs, tspan, inits, showPlot)
    if nargin < 5, showPlot = true; end % Default to showing plot
    % Unpack parameters
    r = params.r;
    a = params.a; 
    m = params.m; 
    b = params.b;
    C_func = funcs.C; 
    prey = inits.prey;
    predator = inits.predator;
    D_func = funcs.D;

    % Create ODE - y(1) is Prey, y(2) is Predator
    odefun = @(t, y) [
        r * y(1) - a * y(1) * y(2) + C_func(y(1)); 
        b * y(1) * y(2) - m * y(2) + D_func(y(2))
    ];

    % Solve
    [T, Y] = ode45(odefun, tspan, [prey; predator]);
    data = [T, Y];

    % plot 1: population dynamics
    if showPlot
        figure;
        subplot(2,1,1);
        plot(T, Y(:,1), 'b', T, Y(:,2), 'r', 'LineWidth', 1.5);
        xlabel('Time'); ylabel('Population');
        legend('Prey', 'Predator'); title('Population Dynamics');
        grid on;

        subplot(2,1,2);
        plot(Y(:,1), Y(:,2), 'k');
        xlabel('Prey'); ylabel('Predator');
        title('Phase Space'); grid on;
    end

    %New!
    %plot 2: slope field
    if showPlot
        % [X, Y] = meshgrid(linspace(0, max(Y(:,1)+5), 30), linspace(0, max(Y(:,2)+5), 30));
        [X, Y] = meshgrid(0:0.01:10, 0:0.05:20);
        U = r * X - a * X .* Y + C_func(X);
        V = b * X .* Y - m * Y + D_func(Y);
        figure;
        quiver(X, Y, U, V, 'AutoScale', 'on');
        xlabel('Prey'); ylabel('Predator');
        title('Slope Field'); grid on;
        hold on
        [X, Y] = meshgrid(0:0.1:10, 0:0.1:20);
        U = r * X - a * X .* Y + C_func(X);
        V = b * X .* Y - m * Y + D_func(Y);
        figure;
        quiver(X, Y, U, V, 'AutoScale', 'on');
        ylim([0 20])
        xlim([0 10])
        hold off
    end

end

