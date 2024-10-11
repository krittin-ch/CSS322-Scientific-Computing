#=
Data Fitting

    For an unkown quadratic equation: y = ct^2 + dt + e
    
    With 5 different coordinates: 
        y_1 = ct_1^2 + dt_1 + e
        y_2 = ct_2^2 + dt_2 + e
        y_3 = ct_3^2 + dt_3 + e
        y_4 = ct_4^2 + dt_4 + e
        y_5 = ct_5^2 + dt_5 + e

    Which is the same as solving

        A= [
            t_1^2 t_1 1
            t_2^2 t_2 1
            t_3^2 t_3 1
            t_4^2 t_4 1
            t_5^2 t_5 1
        ]

        x = [c; d; e]

        b = [y_1; y_2; y_3; y_4; y_5]

        That is, solve a linear system: Ax = b

    The system is overdetermined, as more rows than columns. So, in general ,there is no solution.
    That is, no quadratic function that passes through five data points.

    However, we can find x that minimize ||Ax - b||_2 (2-norm) which can be written as Ax ≊ b

Minimizing ||Ax - b||_2

    (||Ax - b||_2)^2 = (Ax - b)^T (Ax - b)
                     = x^T*A^T*A*x - x^T*A^T*b - b^T*A#*x + b^T*b  (b^T Ax is a scalar)
                     = x^T*A^T*A*x - 2b^T*A*x + b^T*b

Lemma 1: Suppose A has rank n. Then A^T A is symmetrix positive definite.
Lemma 2: f(x) = x^T Cx - 2h^T x + d, where X is symmetric positive definite. Then f has a unique minimizer at x* = C^-1 h.
=#