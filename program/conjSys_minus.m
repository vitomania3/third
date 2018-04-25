function dx_psidt = conjSys_minus(t, x_psi, alpha)
    dx_psidt = [x_psi(2); 
                -alpha - x_psi(1)^3 - 3 * x_psi(1) * sin(x_psi(1)) - x_psi(2)^2;
                3 * x_psi(4) * (x_psi(1)^2 + sin(x_psi(1)) + x_psi(1) * cos(x_psi(1)));
                -x_psi(3) + 2 * x_psi(4) * x_psi(2)];
end

