# Gaussian Quadrature

#=
    Gaussian Quadrature

    For each n, there is a unique n-point Gaussian quadrature rule, and it is of defree 2n - 1
    Highest possilbe accuracy for n nodes, but more difficult to derive

    Use the method of undetermined coefficients. That is, find w_i's and x_i's (2n free variables) so that 
    ∫_{a}^{b} 1 dx, ∫_{a}^{b} x dx, ∫_{a}^{b} x^2 dx, . . ., ∫_{a}^{b} x^{2n-1} dx are coputed exactly (2n equations)

    The resulting system of equations is nonlinear

    Example: 
        Derive a Gaussian quadrature rule for n = 2 on the interval [-1, 1]. 
        Then use the formula to approximate ∫_{-1}^{1} exp(-x^2) dx

        G_2(f) = w_1 * f(x_1) + w_2 * f(x_2)

        2n - 1 = 3

        Exact for ∫_{-1}^{1} 1 dx,
            w_1 + w_2 = 2 = ∫_{-1}^{1} 1 dx

        Exact for ∫_{-1}^{1} x dx,
            w_1 * x_1 + w_2 * x_2 = 0 = ∫_{-1}^{1} x dx

        Exact for ∫_{-1}^{1} x^2 dx,
            w_1 * x_1^2 + w_2 * x_2^2 = 2/3 = ∫_{-1}^{1} x^2 dx

        Exact for ∫_{-1}^{1} x^3 dx,
            w_1 * x_1^3 + w_2 * x_2^3 = 0 = ∫_{-1}^{1} x^3 dx

        That is, find w_1, w_2, x_1, aand x_2 that satisfy
                            w_1 + w_2 = 2,
                w_1 * x_1 + w_2 * x_2 = 0,
            w_1 * x_1^2 + w_2 * x_2^2 = 2/3,
            w_1 * x_1^3 + w_2 * x_2^3 = 0

        Hence, w_1 = w_2 = 1, x_1 = -1/√3, and x_2 = 1/√3

        So, G_2(f) = f(-1/√3) + f(1/√3)

        Therefore, ∫_{-1}^{1} exp(-x^2) dx ≈ G_2(f) = exp(-1/3) + exp(1/3) = 1.4331
=#