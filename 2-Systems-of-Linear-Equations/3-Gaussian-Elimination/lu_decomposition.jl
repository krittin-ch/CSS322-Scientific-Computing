# LU Factorization or LU Decomposition

#=
    Lower Triangular Matrix L :
        - 0 for entries above diagonal
        - 1 for entries on diagonal
        - For entries below digonal, put the multiplier used to zero out the entry a_ij on l_ij

    A = LU

    The (unit) lower triangular matrix L captures the multiplier (factor) used 
    during the Gaussin elimination process of upper triangular matrix U
=#

using LinearAlgebra


function LU_factorization(A)
    n = size(A, 1)
    L = Matrix{Float64}(I, n, n)  # Initialize L as an identity matrix
    U = deepcopy(A)  # U will start as a copy of A
    
    for k in 1:n
        if U[k, k] == 0
            error("Zero pivot element encountered")
        end
        
        for i in k+1:n
            factor = U[i, k] / U[k, k]
            L[i, k] = factor  # Store the factor in L
            U[i, :] -= factor * U[k, :]  # Subtract the row
        end
    end
    
    return L, U
end

A = convert(
    Matrix{Float64}, 
    Matrix([
        1 2 1;
        -3 1 1;
        1 0 3;
    ])
)

L, U = LU_factorization(A)

println("The Lower Triangular Matrix L :")
display(L)

println("The Upper Triangular Matrix L :")
display(U)

# println("A = L * U : ")
# display(L*U)

#=
    With LU Factorization, Ax = b can be solved without needing b from the start.

    Procedure for solving Ax = b :
        1. Factor A = LU
        2. Solve Lw = b for w (forward substitution)
        3. Solve Ux = w for x (backward substitution)

    Verify :
        Let x be the output of the above procedure
        
        Ax = (LU)x = L(Ux) = Lw = b

    Advantages :
            If there are many linear equations to be solved with the same matrix A, 
            then only LU factor is required making the time complexity bounded to O(n^3)

            LU Factorization : O(n^3)
            Forward Substitution (sovle Lw = b for w) : O(n^2)
            Backward Substitution (sovle Ux = w for x) : O(n^2)

            Total Time Complexity : O(n^3) + O(n^2) + O(n^2) = O(n^3)
=#

using Base.Threads

function solve_linear_equation_LTM(A, b) 
    A_size = size(A, 1)
    res = zeros(A_size)

    @threads for i in 1:A_size
        if A[i, i] == 0
            println("The provided matrix is singluar")
            break
        end

        res[i] = b[i] / A[i, i]

        @sync for j in i+1:A_size
            @spawn b[j] -= A[j, i]*res[i]
        end
    end

    return res
end

function solve_linear_equation_UTM(A, b) 
    A_size = size(A, 1)
    res = zeros(A_size)

    @threads for i in A_size:-1:1
        if A[i, i] == 0
            println("The provided matrix is singluar")
            break
        end

        res[i] = b[i] / A[i, i]

        @sync for j in 1:i-1
            @spawn b[j] -= A[j, i]*res[i]
        end
    end

    return res
end

A = convert(
    Matrix{Float64},
    Matrix([
        1 2 1;
        -3 1 1;
        1 0 3
    ])
)

b = convert(
    Vector{Float64},
    Vector([-1; 0; 1])
)

L, U = LU_factorization(A)

println("The Lower Triangular Matrix L :")
display(L)

println("The Upper Triangular Matrix L :")
display(U)
println()

w = solve_linear_equation_LTM(L, b)

println("w (Lw = b) : ")
display(w)
println()

x = solve_linear_equation_UTM(U, w)

println("x (Ux = w) : ")
display(x)