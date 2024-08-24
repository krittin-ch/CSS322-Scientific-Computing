# LU Factorization

using LinearAlgebra

A = rand(3, 3)

# A = transpose(P) * L * U
l, u, p = lu(A)

# display(l*u - A[p, :])

# Turn off pivoting
l, u, p = lu(A, NoPivot())

# A = L * U
# display(l*u - A)

# QR Factorization

q, r = qr(A[:, 1:2])

display(q)
println()
display(r)