Nonlinear Equations

The problem 

    Solve a system of n nonlinear equations (where the right-hand sides are all zeros) in n unknowns
        f_1(x_1, x_2, . . ., x_n) = 0
        f_2(x_1, x_2, . . ., x_n) = 0
                                  .
                                  .
                                  .
        f_n(x_1, x_2, . . ., x_n) = 0

    equivalently,
        f(x) = [f_1(x); f_2(x); . . .; f_n(x)] = [0; 0; . . .; 0]

    This x is called a root of the equation, and a zero of the function f

Examples of nonlinear equations
    In one dimension: f(x) = e^x + cos(x) = 0
    In two dimensions:
        f(x) = [x_1^2 - x_2 + 0.25; cos(x_1)sin(x_2)] = [0; 0]

    Nonlinear equations can have any number of solutions

Corollary of Abel-Ruffini Theorem 
    (a.k.a. Abel's impossibility theorem): Polynomial equations of degree higher than 4 (and more complex nonlinear equations) generally cannot be solved in a finite number of steps.

    So, use an iterative method instead.
        An iterative method produces increasingly accurate approximations to a solution in each iteration and terminates when the result is sufficiently accurate.