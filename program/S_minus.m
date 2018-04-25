function dxdt = S_minus(t, x, alpha)
    dxdt = [x(2); -alpha - x(1)^3 - 3 * x(1) * sin(x(1)) - x(2)^2];
end

