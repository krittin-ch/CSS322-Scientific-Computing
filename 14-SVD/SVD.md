Singular Value Decomposition (SVD)

Theorem
    Any matrix A of dimension m × n can be factored
        A = UΣV^T 

    where U is an orthogonal matrix of dimension m × m, V is an orthogonal matrix of dimension n × n, 
    and Σ is a diagonal matrix whose diagonal entries are denoted as σ_1, σ_2, . . ., σ_p, where p = min(m, n)
    and satisfying σ_1 ≥ σ_2 ≥ . . . ≥ σ_p ≥ 0.

    Example of Σ:
        [2 0
         0 1
         0 0]

        [1 0
         0 0
         0 0]
        
        [4 0 0
         0 4 0]
        
        [4 0 0
         0 4 0
         0 0 3]


SVD yields the matrix 2-norm

Lemma
    Let A be a matrix with dimensions of m × n. Let Q be an orthogonal matrix with dimensions of m × m.
    Then ||QA||_2 = ||A||_2

Lemma
    Let A be a matrix dimension of m × n. Let Q be an orthogonal matrix with dimensions of n × n.
    Then ||AQ||_2 = ||A||_2

Lemma
    Let D be a diagonal matrix with dimensions of m × n. Then ||D||_p = max|d_{ij}| for any p.


Theorem
    If A = UΣV^T (SVD of A), then ||A||_2 = σ_1.

    Proof: 
        ||A||_2 = ||UΣV^T||_2 = ||ΣV^T||_2 = ||Σ||_2 = σ_1
    
    In general, calculating ||A||_2 is more expensive than ||A||_1 or ||A||_∞.
    But the previous three lemmas simplify the computation.
