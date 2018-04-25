function [fix1, fix2] = findFixPoints(alpha)
    fix1 = fzero(@(x) x^3 + 3 * x * sin(x) - alpha, [-10, 10]);
    fix2 = fzero(@(x) x^3 + 3 * x * sin(x) + alpha, [-10, 10]);
    beta1 = -3 * fix1^2 - 3 * sin(fix1) - 3 * fix1 * cos(fix1);
    beta2 = -3 * fix2^2 - 3 * sin(fix2) - 3 * fix2 * cos(fix2);
    if beta1 >= 0
        fprintf("%f - saddle point.\n", fix1);
    else
        fprintf("%f - center point.\n", fix1);
    end
    
    if beta2 >= 0
        fprintf("%f - saddle point.\n", fix2);
    else
        fprintf("%f - center point.\n", fix2);
    end
end

