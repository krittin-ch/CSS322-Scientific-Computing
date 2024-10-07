Integration

    Problem: Compute I(f) = ∫_{a}^{b} f(x) dx

    Analytically, find F(x) such that F'(x) = f(x) and compute F(b) - F(a). 
    However, some integrals cannot be computed analyically (having no cloesd-form antiderivative) for example:  ∫_{a}^{b} e^{-x^2} dx

    For some other functions, their antiderivatives exist but are too complicated to find analyically. So, we approximate I(f) numerically.

    Numerical Quadrature: the numerical approximation of definite univariat integrals.


n-point quadrature rules
    
    Approximate I(f) by
        Q_n(f) = Σ_{i=1}^{n} w_i * f(x_i)
        where a ≤ x_1 ≤ x_2 ≤ . . . ≤ x_n ≤ b 

        x_i's are called nodes or abscissas
        w_i's are called weights or coefficients 

    Many possible rules depending on the choices of n, x_i's and w_i's


    Goal: Choose nodes and weights to get desired accuracy at a reasonable computational cost (The main computational is in evaluating f(x_i))

    A quadrature rule is open if a < x_1 and x_n < b 

    A quadrature rule is closed if a = x_1 and x_n = b 


Derivation of quadrature rules 
    
    1. Choose n nodes x_1, . . ., x_n in some faashion (e.g., equally-spaced points)
    2. Find the polynomial p_{n-1}(t) of degree n-1 that interpolates f at these n points 
    3. Evaluate
        ∫_{a}^{b} p_{n-1}(x) dx 

    and use it as approximation of ∫_{a}^{b} f(x) dx
    
    The derivation can be done on arbitrary f(x), a, and b 
    This results in a general formula that can be used to approximate any definite integrals 


Example of derivation of a new quadrature rule 

        I(f) = ∫_{a}^{b} f(x) dx 

    1. Let us choose n = 1 
    2. Choose x_1 = (a + b) / 2
    3. Find the polynomial interpolant of the one point (x_1, f(x_1))
    4. The interpolant is p_0(t) = f((a + b) / 2)

    So, 
        Q_1(f) = ∫_{a}^{b} p_0(x) dx
               = ∫_{a}^{b} f((a + b) / 2) dx
               = (b - a) * f((a + b) / 2)

    That is w_1 = b - a 
    This is known as the midpoint rule
