function [X, Y, X1, X2] = funcS_plus(t, alpha)
    ind = 0;
    tau = [];

    x0 = [0; 0];
    tspan = [0, t];
    options = odeset('RelTol',1e-5,'AbsTol',1e-5, 'Events', @stop_x2);
    [time, x] = ode45(@(t, x) S_plus(t, x, alpha), tspan, x0, options);

    % !!! Remember: time is column-vector
    if time(end) < t
        ind = ind + 1;
        tau(ind) = time(end);
        tspan = [tau(ind), t];
        X1 = x(:, 1);
        X2 = x(:, 2);
        
        options = odeset('RelTol',1e-5,'AbsTol',1e-5, 'Events', @stop_psi2);
        flag = 1;
        m = size(X1, 1);
        
        for i = 1 : m
            x_psi0 = [X1(i); X2(i); 1; 0];
            [tt, x_psi] = ode45(@(t, x_psi) hybridSys_minus(t, x_psi, alpha), tspan, x_psi0, options);
            plot(x_psi(:, 1), x_psi(:, 2), 'g');
            hold on;

            if tt(end) < t
                if flag
                    ind = ind + 1;
                    tau(ind) = tt(end);
                    flag = 0;
                end
                X1(end + 1) = x_psi(end, 1);
                X2(end + 1) = x_psi(end, 2);
            else
                X(i) = x_psi(end, 1);
                Y(i) = x_psi(end, 2);
            end
        end
        
        tspan = [tau(ind), t];
        flag = 1;
        n = size(X1, 1);

        for i = m : n 
            x_psi0 = [X1(i); X2(i); 1; 0];
            [tt, x_psi] = ode45(@(t, x_psi) hybridSys_plus(t, x_psi, alpha), tspan, x_psi0, options);
            plot(x_psi(:, 1), x_psi(:, 2), 'g');
            hold on;

            if tt(end) < t
                if flag
                    ind = ind + 1;
                    tau(ind) = tt(end);
                    flag = 0;
                end
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

