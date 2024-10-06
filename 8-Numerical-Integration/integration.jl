#=
Integration

Problem: Compute I(f) = ∫_{a}^{b} f(x) dx

Analytically, find F(x) such that F'(x) = f(x) and compute F(b) - F(a). 
However, some integrals cannot be computed analyically (having no cloesd-form antiderivative) for example:  ∫_{a}^{b} e^{-x^2} dx

For some other functions, their antiderivatives exist but are too complicated to find analyically. So, we approximate I(f) numerically.

Numerical Quadrature: the numerical approximation of definite univariat integrals.


Approximate I(f) by
    Q_n(f) = Σ_{i=1}^{n} w_i * f(x_i)
    where a ≤ x_1 ≤ x_2 ≤ . . . ≤ x_n ≤ b 

    x_i's are called nodes or abscissas
    w_i's are called weights or coefficients 

Many possible rules depending on the choices of n, x_i's and w_i's

Goal: 
=#