# Matrix Norms

#=
    If A is a m × n matrix

    Frobenius Norm :

        ||A||_F = sqrt(Σ_i=1_m {Σ_j=1_n {a_ij^2}})
        
=#

A = Matrix{Float64}([
    -2 0;
    2 3
])

function Frobenius_norm(A::Matrix)
    return sqrt(sum(A.^2))
end

function one_norm(A::Matrix)
    return max(sum(abs.(A), dims=1)...)
end

function inf_norm(A::Matrix)
    return max(sum(abs.(A), dims=2)...)
end

println("Frobenius norm of matrix A : ", Frobenius_norm(A))
println("1-norm of matrix A : ", one_norm(A))
println("∞-norm of matrix A : ", inf_norm(A))
