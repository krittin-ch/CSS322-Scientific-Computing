# Stability

#=
    An algorithm is stable if the result it produces is relatively insentitive 
    to perturbations due to approximations made during the computation

    In general, we can think of any problems as computing f(x) for the input x 

    A forward stable algorithm produces nearly the correct result for the exact problem 
    That is, a forward stable algorithm outputs f(x) + ϵ_f, where ϵ_f is small (relatively)
    This ϵ_f is called the forward error

    A forward stable algorithm produces small ϵ_f 


    A backward stable algorithm produces nearly the correct result for the exact problem 
    That is, a backward stable algorithm outputs f(x + ϵ_b), where ϵ_b is small (relatively)
    This ϵ_b is called the backward error

    A backward stable algorithm produces small ϵ_b 


    A backward stability is more often used in practice
        - A backward stable algorithm is also forward stable for well-conditioned problems 
        - For most problems, analyzing the backward error is much easier 
        - The forward error analysis often yields a very pessimistic bound for the error

    A conditionally stable (a.k.a. mixed forward-backward stable or mixed backward-forward stable) 
    algorithm produces nearly the correct result for the nearby problem
    
    That is, the outputs f(x + ϵ_b) + ϵ_f, where ϵ_b and ϵ_f are small (relatively)
    
    A backward stable algorithm is also conditionally stable by definition 
=#

function exp_taylor(x, terms)
   y = 0
   
   for i in 0:terms
        y += x^i / factorial(i)
   end

   return y
end

function exp_taylor_mod(x, terms)
    if x < 0
        return 1 / exp_taylor(x, terms)
    else 
        return exp_taylor(x, terms)
    end
end

x1 = 5
terms = 20

println("exp(5) with 20 terms estimation = ", exp_taylor(x1, terms))

println("exp(-5) with 20 terms estimation = ", exp_taylor(-x1, terms))

println("exp(-5) with 20 terms estimation (modified method) = ", exp_taylor_mod(-x1, terms))
println()

# Another Example

println("Another Example:")

using LinearAlgebra

A = Matrix([
    1e-8 1;
    1 1
])

L, U = lu(A)

println("Built-In LU Factorization")
println("Lower Triangular Matrix: ")
display(L)
println("Upper Triangular Matrix: ")
display(U)
println("A = L * U: ")
display(L * U)
println()

function LU_factorization(A::Matrix)
    n = size(A, 1)
    L = zeros(n, n)
    U = deepcopy(A)

    for i in 1:n 

        for j in i+1:n 
            factor = U[j, i] / U[i, i]
            L[j, i] = factor 
            U[j, :] -= factor * U[i, :]
        end
    end

    L += Matrix(I, n, n)

    return L, U
end

L, U = LU_factorization(A)

println("Custom Library LU Factorization")
println("Lower Triangular Matrix: ")
display(L)
println("Upper Triangular Matrix: ")
display(U)
println("A = L * U: ")
display(L * U)
println()

println("If U is approximated (1 - 1/ϵ ≈ -1/ϵ at U[4, 4])")

U = Matrix([
    1.0e-8 1.0;
    0.0 -1.0e8
])

println("A = L * U: ")
display(L * U)