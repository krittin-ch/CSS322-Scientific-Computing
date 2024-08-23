#=
    Linear Equation :
        a11*x1 + a12*x2 + ... + a1n*xn = b1
        a21*x1 + a22*x2 + ... + a2n*xn = b1
                                    .
                                    .
                                    .
        an1*x1 + an2*x2 + ... + ann*xn = bn

    Matrix Form of the Linear Equation
        A = [
            [a11 a12 . . . a1n],
            [a21 a22 . . . a2n],
            .             .
            .      .      .
            .             .
            [an1 an2 . . . ann]
        ]

        x = [x1 ; x2; . . . ; xn]

        b = [b1 ; b2; . . . ; bn]

        Ax = b 
        
    In scientific computing, column vectors are always applied

    If A is nonsingular, then A^-1 exists.
    The system Ax = b always has a unique solution x = A^-1 * b

    If A is singular, the number of solutions to Ax = b depends on b
    (either no solutions or infinitely many solutions)
=#

# Lower Triangular Matrix

# Example
lower_triangular_matrix = vcat(
    [0 0 0],
    [4 1 0],
    [0 6 -2]
)

#=
or

lower_triangular_matrix = Matrix([
    0 0 0;
    4 1 0;
    0 6 -2
])
=#

# Solving Lower Triangular Linear Systems
L = Matrix([
    -1 0 0;
    -1 2 0;
    2 0 3
])

L_size = size(L)
println("size of matrix L = ", L_size)

b = [1; 0; -2]
b = reshape(b, (3, 1))

b_size = size(b)
println("size of matrix B = ", b_size)
println()

# Inverse Matrix Method
x = inv(L)*b

println("Solution of the Inverse Matrix Method : ")
display(x)
println()

# Version I (for-loop)

x1 = zeros(L_size[1], b_size[2])
# x[i] = x[i, 1], i.e. same meaning when dimension is either (m, 1) or (1, n)

L1 = deepcopy(L)
b1 = deepcopy(b)

#=
    B = copy(A) (B is affected by changes to A)
    B = deepcopy(A) (B is not affected by changes to A)
=#

# Time Complexity: O(n^2)
for i in 1:L_size[1]
    if L1[i, i] == 0 # Matrix is singular
        println("The provided matrix is singular")
        break
    end

    for j in 1:i-1
        b1[i] -= L1[i, j]*x1[j]
    end
    
    x1[i] = b1[i]/L1[i, i]
end

println("Solution of Version I : ")
display(x1)
println()

# Version II (for-loop concerrently)
# Time Complexity: O(n^2)

x2 = zeros(L_size[1], b_size[2])

L2 = deepcopy(L)
b2 = deepcopy(b)

#=
    Normal Code :

        for j in 1:L_size[1]
            if L2[j, j] == 0 # Matrix is singular
                println("The provided matrix is singular")
                break
            end

            x2[j] = b2[j]/L2[j, j]

            for i in j+1:L_size[1]
                b2[i] -= L2[i, j]*x2[j]
            end
        end
=#

#=
    Parallel Processing with `@threads` :
        Wrap the outer loop with the `@threads` macro, which tells Julia to execute the loop in parallel using multiple threads.

        Inside the loop, the `@sync` macro is called to ensure that the inner loop is executed synchronously,
        meaning that the results of the inner loop are collected before moving on to the next iteration of the outer loop.

        The @spawn macro is called to execute the inner loop in parallel.
        This creates a new task that runs concurrently with the main thread.
=#

using Base.Threads

# Check the number of threads
num_threads = nthreads()
println("The number of threads : $num_threads")

# The master thread
master_thread = threadid()
println("The id of master thread : $master_thread")
println()

@threads for j in 1:L_size[1]
    if L2[j, j] == 0 # Matrix is singular
        println("The provided matrix is singular")
        break
    end

    x2[j] = b2[j]/L2[j, j]

    @sync for i in j+1:L_size[1]
        @spawn b2[i] -= L2[i, j]*x2[j]
    end
end

#=
    Distributed Computing Code :

        # `@distributed` module to parallelize the code using multiple processes instead of threads

        using Distributed

        # The Number of Worker Processors and The Total Number of Processors

        # nworkers() usually equal to the number of CPU cores
        num_cores = nworkers()  
        println("The laptop has $num_cores CPU cores")

        # nprocs() is one more than nworkers() since it inclueds the main processor
        num_procs = nprocs()
        println("The laptop has $num_procs total processors")

        addprocs(num_cores)

        @distributed for j in 1:A_size[1]
            if L2[j, j] == 0 # Matrix is singular
                println("The provided matrix is singular")
                break
            end
            
            x2[j] = b2[j]/L2[j, j]
            
            @distributed for i in j+1:A_size[1]
                b2[i] -= L2[i, j]*x2[j]
            end
        end
=#

println("Solution of Version II : ")
display(x2)
