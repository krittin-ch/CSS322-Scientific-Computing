# QR Iteration

#=
    QR Iteration

        The basic QR iteration is as follow:
            
            M^(0) = A
            
            For k = 0, 1, 2, . . . 
                Factor M^(k) = Q^(k) * R^(k) (Know M^(k). Compute Q^(k) and R^(k) byQR factorization)

                Define M^(k+1) := R^(k) * Q^(k) (Know Q^(k) and R^(k). Compute M^(k+1))
=#

using LinearAlgebra
# using LinearSolve

function Householder_matrix(v::Vector)
    n = size(v, 1)
    return I(n) - 2 * (v * transpose(v)) / (transpose(v) * v)
end

function Householder_multiplication(v::Vector, u::Vector)
    return u - 2 * (transpose(v) * u) / (transpose(v) * v) * v
end

function Householder_transformation(A::Matrix, H::Matrix)
    m, n = size(A)
    a = A[:, 1]

    alpha = a[1] >= 0 ? -norm(a, 2) : norm(a, 2)

    e_1 = zeros(size(a))
    e_1[1] = 1

    v = a - alpha * e_1
    
    for i = 1:n
        A[:, i] = Householder_multiplication(v, A[:, i])
    end

    for i = 1:m
        H[:, i] = Householder_multiplication(v, H[:, i])
    end 

    return H, A
end

function get_H(A::Matrix, H_prev::Matrix)
    m, n = size(A)
    
    H, A = Householder_transformation(A, H_prev)

    if m >= 2 && n >= 2
        H[2:end, 2:end], A[2:end, 2:end] = get_H(A[2:end, 2:end], H[2:end, 2:end])
    end

    return H, A
end

function QR_factorization(A::Matrix)
    H, _ = get_H(A, convert(Matrix{Float64}, I(size(A, 1))))

    Q = convert(Matrix{Float64}, transpose(H))
    R = H * A

    return Q, R
end

function QR_iteration(A::Matrix)
    n = 10

    M = deepcopy(A)
    for i = 1:n
        Q, R = qr(M)
        M = R * Q
        # println("Iteration ", i, ":")
        # display(M)
    end

    return M
end

A = Matrix{Float64}([
    4 -1;
    -1 6
])

M = QR_iteration(A)

println("Eigenvalues: ")
display(M)