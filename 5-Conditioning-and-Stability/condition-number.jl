# Condtion Number

#=
    Condtion number of a problem is the ratio of the relative change in the solution to the relative change in the input 

    For example, y = f(x)
        Condtion number = |(f(x̂) - f(x)) / f(x)| / |(x̂ - x) / x|

    However, the above definition is very difficult to compute for complex problems, 
    a rough estimate or an upper bound of condition numbers over some domain of inputs are usually used instead

    
    conditon number estimation if Ax = b
        (A + E)x̂ = b + e for E/A ≤ δ and e/b ≤ δ as δ is very small constant and greater than zero

        Ax̂ + Ex̂ = b + e 
        Ax̂ = b + e - Ex̂
        x̂ = A^-1 b + A^-1 e - A^-1 Ex̂
        x̂ = x + A^-1 bδ - A^-1 Aδ x̂

        ||x̂ - x|| = ||A^-1|| ⋅ δ||b|| - ||A^-1|| ⋅ δ||A|| ⋅ ||x̂||
        
        ||x̂ - x|| ≤ ||A^-1|| ⋅ δ||b|| - δ ⋅ κ(A) ⋅ (||x̂ - x|| + ||x||) denote κ(A) = ||A^-1|| ⋅ ||A||
        
        ||x̂ - x|| ≤ δ||A^-1|| ⋅ ||b|| - δκ(A) ⋅ ||x̂ - x|| + δκ(A) ⋅ ||x||
        
        ||x̂ - x|| + δκ(A) ⋅ ||x̂ - x|| ≤ δ||A^-1|| ⋅ ||b|| + δκ(A) ⋅ ||x||
        
        As ||b|| = ||Ax|| ≤ ||A|| ⋅ ||x||
        
        ||x̂ - x|| + δκ(A) ⋅ ||x̂ - x|| ≤ δ||A^-1|| ⋅ ||A|| ⋅ ||x|| + δκ(A) ⋅ ||x||
        (1 + δκ(A)) ⋅  ||x̂ - x|| ≤ 2δκ(A) ⋅ ||x||
        
        ||x̂ - x|| / ||x|| ≤ 2δκ(A) / (1 + δκ(A))


        Hence, cond(A) = κ(A) = ||A|| ⋅ ||A^-1||

        If A is singular, cond(A) = ∞
        The larger cond(A), the more ill-conditioned the linear system
=#

#=
    cond(A) properties

    1. cond(A) = ||A|| ⋅ ||A^-1||
    2. cond_p(A) ≥ 1
    3. cond_p(I) = 1
    4. cond(αA) = cond(A) for α ≠ 0
    5. cond_p(D) = max_i{|d_ii|} / min_i{|d_ii|} if D is a diagonal matrix, that is, d_ij ≠ 0 for i ≠ j

    The closer cond(A) to 1, the more well-conditioned
=#

function one_norm(A::Matrix)
    return max(sum(abs.(A), dims=1)...)
end

function inf_norm(A::Matrix)
    return max(sum(abs.(A)))
end

function Frobenius_norm(A::Matrix)
    return sqrt(sum(A.^2))
end

A = Matrix{Float64}([  
    2 0;
    -1 1
])

inv_A = inv(A)

cond_1 = one_norm(A) * one_norm(inv_A)
println("cond_1 of A is ", cond_1)

cond_inf = inf_norm(A) * inf_norm(inv_A)
println("cond_inf of A is ", cond_inf)

cond_F = Frobenius_norm(A) * Frobenius_norm(inv_A)
println("cond_F of A is ", cond_F)