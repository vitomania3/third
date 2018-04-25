function [value, isterminal, direction] = stop_x2(t, x)
    value = x(2);
    isterminal = 1;
    direction = 0;
end
