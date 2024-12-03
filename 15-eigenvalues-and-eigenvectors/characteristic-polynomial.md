Characteristic Polynomial
    Suppose λ is an eigenvalue of A and x is the associated eigenvector.
    This means: There exists x ≠ 0 s.t. Ax = λx.
    This is te same as ∃x ≠ 0 s.t. (A - λI)x = 0.
    Same as A - λI is singular.
    Same as det(A - λI) = 0.
    det(A - λI) is a polynomial in λ called the characteristic polynomial. The roots of this polynomial are the eigenvalues of A.


    The characteristic polynomial of an n-by-n matrix is always of degree n.
    So an n-by-n matrix has exactly n eigenvalues, but not necessarily distinct.
    
    Two complications:
        1. Even if A is real, eigenvalues and eigenvectors may be complex.
        2. In general, eigenvalues are irrational numbers even if entries of A are rational.

    Eigenvalues of matrix larger than 4-by-4 cannot be found in a finite number of steps 
    (Corollary of Abel-Ruffini theorem. Same as solving nonlinear equations).
    
    Solving characteristic polynomial for eigenvalues (by any method including iterative ones) is not useful for large matrices.
        Requires too many operations and gives inaccurate results.

    
    
    Find eigenvalues of [3 -1; -1 3] by formin and solving the characteristic polynomial.

        det([3 -1; -1 3] - λ[1 0; 0 1]) = det([3-λ -1; -1 3-λ])
                                      0 = (3-λ)^2 - 1

        λ = 2 and 4
