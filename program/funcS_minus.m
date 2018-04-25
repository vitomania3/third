function [X, Y, X1, X2] = funcS_minus(t, alpha)
    ind = 0;

    x0 = [0; 0];
    tspan = [0, t];
    options = odeset('RelTol',1e-5,'AbsTol',1e-5, 'Events', @stop_x2);
    [time, x] = ode45(@(t, x) S_minus(t, x, alpha), tspan, x0, options);

    % !!! Remember: time is column-vector
    if time(end) < t
        cntPoints = size(time, 1);
        t_star = time(end);
        tspan = [t_star, t];
        X1 = x(:, 1);
        X2 = x(:, 2);
        
        options = odeset('RelTol',1e-5,'AbsTol',1e-5, 'Events', @stop_psi2);
        for i = 1 : cntPoints
            x_psi0 = [X1(i); X2(i); -1; 0];
            [tt, x_psi] = ode45(@(t, x_psi) hybridSys_plus(t, x_psi, alpha), tspan, x_psi0, options);
            plot(x_psi(:, 1), x_psi(:, 2), 'g');
            hold on;

            if tt(end) < t
                ind = ind + 1;
                tau(ind) = tt(end);
                X1(end + 1) = x_psi(end, 1);
                X2(end + 1) = x_psi(end, 2);
            else
                X(i) = x_psi(end, 1);
                Y(i) = x_psi(end, 2);
            end
        end
    else
        warning('Too small time!');
    end
end

