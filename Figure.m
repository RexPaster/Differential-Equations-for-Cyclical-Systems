%% SETTINGS
    % Global Setting
        globalvars.timespan = [0 1500]; %Simulation Time Span
    
    % Subfigure A Numerical Parameters
        subfigureA.xnaught = 5;
        subfigureA.ynaught = 5;
        subfigureA.r = 0.1;
        subfigureA.a = 0.1;
        subfigureA.b = 0.3;
        subfigureA.m = 0.2;
        subfigureA.c = 0.01;
        subfigureA.d = 0;
    
    % Subfigure A Clauses
        subfigureA.clauses.cIsDependent = false; %Uses C(x) = c if false | C(x) = c/x if true
        subfigureA.clauses.dIsDependent = false; %Uses D(y) = d if false | D(y) = d/x if true
    
    % Subfigure B Numerical Parameters
        subfigureB.xnaught = 5;
        subfigureB.ynaught = 5;
        subfigureB.r = 0.1;
        subfigureB.a = 0.1;
        subfigureB.b = 0.3;
        subfigureB.m = 0.2;
        subfigureB.c = 0.01;
        subfigureB.d = 0;
    
    % Subfigure B Clauses
        subfigureB.clauses.cIsDependent = true; %Uses C(x) = c if false | C(x) = c/x if true
        subfigureB.clauses.dIsDependent = false; %Uses D(y) = d if false | D(y) = d/x if true
    
    % Subfigure C Numerical Parameters
        subfigureC.xnaught = 5;
        subfigureC.ynaught = 5;
        subfigureC.r = 0.1;
        subfigureC.a = 0.1;
        subfigureC.b = 0.3;
        subfigureC.m = 0.2;
        subfigureC.c = 0;
        subfigureC.d = 0.01;
    
    % Subfigure C Clauses
        subfigureC.clauses.cIsDependent = false; %Uses C(x) = c if false | C(x) = c/x if true
        subfigureC.clauses.dIsDependent = false; %Uses D(y) = d if false | D(y) = d/x if true
    
    % Subfigure D Numerical Parameters
        subfigureD.xnaught = 5;
        subfigureD.ynaught = 5;
        subfigureD.r = 0.1;
        subfigureD.a = 0.1;
        subfigureD.b = 0.3;
        subfigureD.m = 0.2;
        subfigureD.c = 0;
        subfigureD.d = 0.01;
    
    % Subfigure D Clauses
        subfigureD.clauses.cIsDependent = false; %Uses C(x) = c if false | C(x) = c/x if true
        subfigureD.clauses.dIsDependent = true; %Uses D(y) = d if false | D(y) = d/x if true
    
    % Subfigure E Numerical Parameters
        subfigureE.xnaught = 5;
        subfigureE.ynaught = 5;
        subfigureE.r = 0.1;
        subfigureE.a = 0.1;
        subfigureE.b = 0.3;
        subfigureE.m = 0.2;
        subfigureE.c = 0;
        subfigureE.d = 0;
    
    % Subfigure E Clauses
        subfigureE.clauses.cIsDependent = false; %Uses C(x) = c if false | C(x) = c/x if true
        subfigureE.clauses.dIsDependent = false; %Uses D(y) = d if false | D(y) = d/x if true


%% Initialization
    % Set Migration/Immigration Functions Using Helper Function for Code
    % Cleanlyness
        function f = makeCoeff(val, isDependent) %Helper Function
            if isDependent
                f = @(x) val./x;
            else
                f = @(x) val;
            end
        end
    
    %Subfigure A Function Initialization
        subfigureA.C = makeCoeff(subfigureA.c, subfigureA.clauses.cIsDependent);
        subfigureA.D = makeCoeff(subfigureA.d, subfigureA.clauses.dIsDependent);
    
    %Subfigure B Function Initialization
        subfigureB.C = makeCoeff(subfigureB.c, subfigureB.clauses.cIsDependent);
        subfigureB.D = makeCoeff(subfigureB.d, subfigureB.clauses.dIsDependent);
    
    %Subfigure C Function Initialization
        subfigureC.C = makeCoeff(subfigureC.c, subfigureC.clauses.cIsDependent);
        subfigureC.D = makeCoeff(subfigureC.d, subfigureC.clauses.dIsDependent);
    
    %Subfigure D Function Initialization
        subfigureD.C = makeCoeff(subfigureD.c, subfigureD.clauses.cIsDependent);
        subfigureD.D = makeCoeff(subfigureD.d, subfigureD.clauses.dIsDependent);

    %Subfigure E Function Initialization
        subfigureE.C = makeCoeff(subfigureE.c, subfigureE.clauses.cIsDependent);
        subfigureE.D = makeCoeff(subfigureE.d, subfigureE.clauses.dIsDependent);

    % Create ode solvers using helper function
        function solver = initODE(a, b, m, r, C, D) %Helper Function
            solver = @(t, y) [
                   r * y(1) - a * y(1) * y(2) + C(y(1)); 
                   b * y(1) * y(2) - m * y(2) + D(y(2))
                   ];
        end
    
    %Solver Initializations
        subfigureA.solver = initODE(subfigureA.a, subfigureA.b, subfigureA.m, subfigureA.r, subfigureA.C, subfigureA.D);
        subfigureB.solver = initODE(subfigureB.a, subfigureB.b, subfigureB.m, subfigureB.r, subfigureB.C, subfigureB.D);
        subfigureC.solver = initODE(subfigureC.a, subfigureC.b, subfigureC.m, subfigureC.r, subfigureC.C, subfigureC.D);
        subfigureD.solver = initODE(subfigureD.a, subfigureD.b, subfigureD.m, subfigureD.r, subfigureD.C, subfigureD.D);
        subfigureE.solver = initODE(subfigureE.a, subfigureE.b, subfigureE.m, subfigureE.r, subfigureE.C, subfigureE.D);

%% Run Models
    [subfigureA.solved.T, subfigureA.solved.Y] = ode45(subfigureA.solver, globalvars.timespan, [subfigureA.xnaught; subfigureA.ynaught]);
    [subfigureB.solved.T, subfigureB.solved.Y] = ode45(subfigureB.solver, globalvars.timespan, [subfigureB.xnaught; subfigureB.ynaught]);
    [subfigureC.solved.T, subfigureC.solved.Y] = ode45(subfigureC.solver, globalvars.timespan, [subfigureC.xnaught; subfigureC.ynaught]);
    [subfigureD.solved.T, subfigureD.solved.Y] = ode45(subfigureD.solver, globalvars.timespan, [subfigureD.xnaught; subfigureD.ynaught]);
    [subfigureE.solved.T, subfigureE.solved.Y] = ode45(subfigureE.solver, globalvars.timespan, [subfigureE.xnaught; subfigureE.ynaught]);

%% Plot
    %A: Dynamics
        subplot(3,4,1)
        plot(subfigureA.solved.T, subfigureA.solved.Y(:,1), 'b', subfigureA.solved.T, subfigureA.solved.Y(:,2), 'r', 'LineWidth', 1.5);
        xlabel('Time'); ylabel('Population');
        legend('Prey', 'Predator'); title('Population Dynamics');
        grid on;
    %A: Phase States
        subplot(3,4,2)
        plot(subfigureA.solved.Y(:,1), subfigureA.solved.Y(:,2), 'k');
        xlabel('Prey'); ylabel('Predator');
        title('Phase Space'); grid on;

    %B: Dynamics
        subplot(3,4,3)
        plot(subfigureB.solved.T, subfigureB.solved.Y(:,1), 'b', subfigureB.solved.T, subfigureB.solved.Y(:,2), 'r', 'LineWidth', 1.5);
        xlabel('Time'); ylabel('Population');
        legend('Prey', 'Predator'); title('Population Dynamics');
        grid on;
    
    %B: Phase States
        subplot(3,4,4)
        plot(subfigureB.solved.Y(:,1), subfigureB.solved.Y(:,2), 'k');
        xlabel('Prey'); ylabel('Predator');
        title('Phase Space'); grid on;
    
    %C: Dynamics
        subplot(3,4,5)
        plot(subfigureC.solved.T, subfigureC.solved.Y(:,1), 'b', subfigureC.solved.T, subfigureC.solved.Y(:,2), 'r', 'LineWidth', 1.5);
        xlabel('Time'); ylabel('Population');
        legend('Prey', 'Predator'); title('Population Dynamics');
        grid on;

    %C: Phase States
        subplot(3,4,6)
        plot(subfigureC.solved.Y(:,1), subfigureC.solved.Y(:,2), 'k');
        xlabel('Prey'); ylabel('Predator');
        title('Phase Space'); grid on;
    
    %D: Dynamics
        subplot(3,4,7)
        plot(subfigureD.solved.T, subfigureD.solved.Y(:,1), 'b', subfigureD.solved.T, subfigureD.solved.Y(:,2), 'r', 'LineWidth', 1.5);
        xlabel('Time'); ylabel('Population');
        legend('Prey', 'Predator'); title('Population Dynamics');
        grid on;

    %D: Phase States
        subplot(3,4,8)
        plot(subfigureD.solved.Y(:,1), subfigureD.solved.Y(:,2), 'k');
        xlabel('Prey'); ylabel('Predator');
        title('Phase Space'); grid on;
    
    %E: Dynamics
        subplot(3,4,10)
        plot(subfigureE.solved.T, subfigureE.solved.Y(:,1), 'b', subfigureE.solved.T, subfigureE.solved.Y(:,2), 'r', 'LineWidth', 1.5);
        xlabel('Time'); ylabel('Population');
        legend('Prey', 'Predator'); title('Population Dynamics');
        grid on;
    
    %E: Phase States
        subplot(3,4,11)
        plot(subfigureE.solved.Y(:,1), subfigureE.solved.Y(:,2), 'k');
        xlabel('Prey'); ylabel('Predator');
        title('Phase Space'); grid on;
%% Formatting & Labeling
    % Increase vertical spacing between rows
        % Collect axes handles explicitly
        ax = gobjects(12,1);
        
        for i = [1 2 3 4 5 6 7 8 10 11]
            ax(i) = subplot(3,4,i);
        end
        
        % Add vertical spacing
        gap = 0.03;
        
        % Row 2 (5–8)
        for i = 5:8
            p = ax(i).Position;
            p(2) = p(2) - gap;
            ax(i).Position = p;
        end
        
        % Row 3 (10–11)
        for i = [10 11]
            p = ax(i).Position;
            p(2) = p(2) - 2*gap;
            ax(i).Position = p;
        end

    % Titles & Labels

    drawnow  % ensure all subplot positions are finalized
    
    % ROW TITLES
        rowTitles = { ...
            'With prey immigrants', ...
            'With preditor immagrants', ...
            'Without immagrants'};
        
        rowStart = [1 5 10];          % first subplot in each row
        rowEnd   = [4 8 11];          % last subplot in each row (adjust for bottom row)
        
        for k = 1:3
            pFirst = ax(rowStart(k)).Position;
            pLast  = ax(rowEnd(k)).Position;
        
            % Center above actual subplots
            xCenter = (pFirst(1) + pLast(1) + pLast(3))/2;
        
            % Vertical position slightly above axes
            yPos = pFirst(2) + pFirst(4) + 0.03;
        
            annotation('textbox',...
                [xCenter-0.15 yPos 0.3 0.03],...
                'String',rowTitles{k},...
                'HorizontalAlignment','center',...
                'VerticalAlignment','bottom',...
                'EdgeColor','none',...
                'FontSize',12,...
                'FontWeight','bold');
        end

    % PAIR LABELS
        pairTitles = { ...
            'C(x) = c, D(y) = 0', ...
            'C(x) = c/x, D(y) = 0', ...
            'C(x) = 0, D(y) = d', ...
            'C(x) = 0, D(y) = 0/y', ...
            'C(x) = 0, D(y) = 0'};
        
        pairs = [1 2; 3 4; 5 6; 7 8; 10 11];
        
        for k = 1:size(pairs,1)
            p1 = ax(pairs(k,1)).Position;
            p2 = ax(pairs(k,2)).Position;
        
            % Horizontal center between the two subplots
            xCenter = (p1(1) + p2(1) + p2(3))/2;
        
            % Vertical position slightly above axes
            yPos = p1(2) + p1(4) + 0.007;
        
            annotation('textbox',...
                [xCenter-0.15 yPos 0.3 0.025],...
                'String',pairTitles{k},...
                'HorizontalAlignment','center',...
                'VerticalAlignment','bottom',...
                'EdgeColor','none',...
                'FontSize',10);
        end

    % Panel Letters
        letters = {'a','b','c','d','e'};
        for k = 1:length(letters)
            p = ax(pairs(k,1)).Position;  % first subplot in the pair
        
            xPos = p(1) - 0.02;  % a little left of the axes
            yPos = p(2) + p(4) + 0.01;  % a little above the axes
        
            annotation('textbox',...
                [xPos yPos 0.03 0.03],...
                'String',letters{k},...
                'HorizontalAlignment','left',...
                'VerticalAlignment','top',...
                'EdgeColor','none',...
                'FontWeight','bold',...
                'FontSize',12);
        end

%% Note on AI Usage
% Ai was used for help with abnormal formatting, such as Full Row TItles,
% and Letter Labeling. This was done with promts like "Help add Labels to
% the right of each pair of graphs.", "Help space out each row to make room
% for titles on each row.", "Help add Titles for each pair of graphs" and
% "Help add Row Titles". Code was then adjusted for formatting needs based
% of off the Ai generated figure fomatting code. No code above the
% "Formatting & Labeling" header is generated using AI.
