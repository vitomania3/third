function [value, isterminal, direction] = stop_psi2(t, x_psi)
    value = x_psi(4);

    isterminal = 1;
    direction = 0;
end
