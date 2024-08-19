
# Lower Triangular Matrix

# Example
upper_triangular_matrix = vcat(
    [0 4 1],
    [0 1 5],
    [0 0 0]
)

U = Matrix([
    3 4 0;
    0 1 -1;
    0 0 -2;
])

b = Vector([0; 2; 2])

U_size = size(U)
b_size = size(b)

println("size of matrix U = $U_size")
println("size of column vector b = $b_size")

# Inverse Matrix Method

x = inv(U) * b

# println("Solution of the Inverse Matrix Method : ")
# display(x)

# Version I (for-loop)

U1 = deepcopy(U)
b1 = deepcopy(b)

x1 = zeros(U_size[1])

for i in U_size[1]:-1:1
    if U[i, i] == 0
        println("The provided matrix is singular")
        break
    end
    
    for j in i+1:U_size[1]
        b1[i] -= U1[i, j]*x1[j]
    end

    x1[i] = b1[i]/U1[i, i]
end

# println("Solution of Version I : ")
# display(x1)

# Version II (for-loop concerrently)

using Base.Threads

num_threads = nthreads()
println("The number of threads : $num_threads")

U2 = deepcopy(U)
b2 = deepcopy(b)

x2 = zeros(U_size[1])

@threads for j in U_size[1]:-1:1
    if U2[j, j] == 0
        println("The provided matrix is singular")
    end

    x2[j] = b2[j] / U2[j, j]

    @sync for i in 1:j-1
        @spawn b2[i] -= U2[i, j] * x2[j]
    end
end

println("Solution of Version II : ")
display(x2)


