using LinearAlgebra

A = Matrix{Float64}([
    1 2; -1 1
])

U = Matrix{Float64}([
    0.9571 0.2898;
    0.2898 -0.9571
])

Sigma = Matrix{Float64}([
    2.3028 0;
    0 1.3028
])

V = Matrix{Float64}([
    0.2898 0.9571;
    0.9571 -0.2898
])

new_A = U*Sigma*transpose(V)
display(new_A)
