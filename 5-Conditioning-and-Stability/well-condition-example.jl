# Well-Condition Example

#=
    [1 1; 0 1] x = [3; 4] is well-conditioned

    [1 2; 3 6+δ]x = [1; 2] is ill-conditioned
    
=#

using LinearSolve

function one_norm_mat(A::Matrix)
    return max(sum(abs.(A), dims=1)...)
end

function one_norm_vec(v::Vector)
    return sum(abs.(v))
end

println("Well-Condtioned Example:")

A1 = Matrix{Float64}([
    1 1;
    0 1
])

b = Vector{Float64}([3; 4])

prob1 = LinearProblem(A1, b)
x1 = solve(prob1).u

println("The Solution of the Linear Equation:")
display(x1)

A2 = Matrix{Float64}([
    1 1;
    0 1+1e-8;
])
    
prob2 = LinearProblem(A2, b)
x2 = solve(prob2).u

println("The Solution of the Perturbed (1e-8) Linear Equation:")
display(x2)

r1 = one_norm_mat(A1 - A2) / one_norm_mat(A1)
println("Relative Change in the Input: ", r1)

r2 = one_norm_vec(x1 - x2) / one_norm_vec(x1)
println("Relative Change in the Input: ", r2)
        

# Ill-Condtioned Example
println("Ill-Condtioned Example:")
        
C1 = Matrix{Float64}([
    1 2;
    3 6
])

d = Vector{Float64}([1; 2])

prob3 = LinearProblem(C1, d)
x3 = solve(prob3).u

println("The Solution of the Linear Equation:")
display(x3)

C2 = Matrix{Float64}([
    1 2;
    3 6+1e-2;
])

prob4 = LinearProblem(C2, d)
x4 = solve(prob4).u

println("The Solution of the Perturbed (1e-2) Linear Equation:")
display(x4)

r3 = one_norm_mat(C1 - C2) / one_norm_mat(C1)
println("Relative Change in the Input: ", r3)

r4 = one_norm_vec(x3 - x4) / one_norm_vec(x3)
println("Relative Change in the Input: ", r4)
