function [X, Y, X1, X2, array, array1] = reachset(t, alpha)
    numOfPoints = 20;
    % Coordinates of reachset;
    Bound = struct('x', [], 'y', []);

    % Coordinates of curve switch;
    Switch = struct('x', [], 'y', []);

    % Coordinates of trajectories;
    Traj = struct('x', [], 'y', []);

    % Array of trajectories
    array = {};
    array1 = {};
    ind = 0;

    %///////////////////////////////////////
    x0 = [0; 0];
    tspan = linspace(0, t, numOfPoints);
    options = odeset('RelTol',1e-5,'AbsTol',1e-5, 'Events', @stop_x2);
    [time, x] = ode45(@(t, x) S_plus(t, x, alpha), tspan, x0, options);

    Switch.x = x(:, 1);
    Switch.y = x(:, 2);

    tspan = linspace(0, t, numOfPoints);
    % tspan = [0, t];
    options = odeset('RelTol',1e-5,'AbsTol',1e-5, 'Events', @stop_psi2);

    for i = 1 : numOfPoints
        x0 = [Switch.x(i), Switch.y(i), 1, 0];
        [time, x] = ode45(@(t, x) conjSys_minus(t, x, alpha), tspan, x0, options);
    %     plot(x(:, 1), x(:, 2), 'b')
    %     hold on;

        Traj.x = x(:, 1);
        Traj.y = x(:, 2);
        ind = ind + 1;
        array{ind} = Traj;

        if time(end) < t
            t_sw = time(end);
            Switch.x(end + 1) = x(end, 1);
            Switch.y(end + 1) = x(end, 2);
        else
            Bound.x(i) = x(end, 1);
            Bound.y(i) = x(end, 2);
        end
    end

    X = Bound.x';
    Y = Bound.y';
    X1 = Switch.x;
    X2 = Switch.y;

    %///////////////////////////////////////////////
    ind = 0;

    x0 = [0; 0];
    tspan = linspace(0, t, numOfPoints);

    % tspan = linspace(0, t, 100);
    options = odeset('RelTol',1e-5,'AbsTol',1e-5, 'Events', @stop_x2);
    [time, x] = ode45(@(t, x) S_minus(t, x, alpha), tspan, x0, options);

    Switch.x = x(:, 1);
    Switch.y = x(:, 2);

    tspan = linspace(0, t, numOfPoints);
    options = odeset('RelTol',1e-5,'AbsTol',1e-5, 'Events', @stop_psi2);
    for i = 1 : size(Switch.x, 1)
        x0 = [Switch.x(i), Switch.y(i), -1, 0];
        [time, x] = ode45(@(t, x) conjSys_plus(t, x, alpha), tspan, x0, options);
    %     plot(x(:, 1), x(:, 2), 'g')
    %     hold on;
        Traj.x = x(:, 1);
        Traj.y = x(:, 2);
        ind = ind + 1;
        array1{ind} = Traj;

        if time(end) < t
            t_sw = time(end);
            Switch.x(end + 1) = x(end, 1);
            Switch.y(end + 1) = x(end, 2);
        else
            Bound.x(i) = x(end, 1);
            Bound.y(i) = x(end, 2);
        end
    end

    X1 = cat(1, rot90(rot90(X1(2:end))), Switch.x);
    X2 = cat(1, rot90(rot90(X2(2:end))), Switch.y);
    tmp1 = cat(1, rot90(rot90(Bound.x))', array{end}.x);
    tmp2 = cat(1, tmp1, rot90(rot90(X)));
    X = cat(1, tmp2, array1{end}.x);

    tmp1 = cat(1, rot90(rot90(Bound.y))', array{end}.y);
    tmp2 = cat(1, tmp1, rot90(rot90(Y)));
    Y = cat(1, tmp2, array1{end}.y);
end

