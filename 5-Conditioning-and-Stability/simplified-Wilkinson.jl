# Simplified Winkinson

#=
    Suppose we solve Ax = b using GEPP ans the four-steps procedure in presence of roundoff
    The computed x̂ satisfied 
        (A + E)x̂ = b

    where E satisfies 
        ||E||_inf / ||A||_inf ≤ ρηϵ_mach + O(ϵ^2_mach)

    In the extremely worst case, ρ = 2^(n-1). In practice, however, it is usually observed that ρ ≈ 2

    - In short, GEPP is backward stable (in practice)
    - GECP yields even smaller ρ in both theory and practice 
    but the small increase in stability is usually not worth the extra computational cost 
    
    In which case can we expect an accurate solution?
        - using a stable algorithm on a well-conditioned problem?
        - Using an unstable algorithm on an ill-condtioned problem?
        - Using an unstable algorithm on a well-conditioned problem? 
        - Using a stable algorithm on an ill-conditioned problem?

    Answer: Only when we use a stable algorithm on a well conditioned problem can we expect an accurate result.

    For example, tan(x) function which affects a very relatively large change at x = π/2
    
    Given small ϵ_1, ϵ_2 > 0, tan(x - ϵ_1) is a very large positive number while tan(x + ϵ_2) is a very large negative number 

    Thereforem the problem is ill-conditioned
=#

x = pi / 2

eps = 1e-4


println("tan(x) = ", tan(x))
println("tan(x + ϵ) = ", tan(x + eps))
println("tan(x - ϵ) = ", tan(x - eps))