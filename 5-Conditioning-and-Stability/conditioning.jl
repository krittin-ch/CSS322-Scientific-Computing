# Conditioning

#=
    A problem is said to be well-conditioned, or insensitive, if a small 
    change in the input data causes a resonably small change in the solution.

    A problem is said to be ill-conditioned, or sensitive, if a small 
    change in the input data causes a much larger change in the solution relatively.
=#

function absolute_error(true_val, approx_val)
    abs(approx_val - true_val)
end

function relative_error(true_val, approx_val)
    absolute_error(true_val, approx_val) / true_val
end

# Ill-Conditioned Example
println("Ill-Conditioned Example")

x1 = 1e2

val_1 = cos(x1 * pi)

val_2 = cos((x1 + 1) * pi)

println("Exact Value : ", val_1)
println("Approximated Value : ", val_2)

println("Absolute Error of the Input : ", absolute_error(x1 * pi, (x1 + 1) * pi))
println("Relative Error of the Input : ", relative_error(x1 * pi, (x1 + 1) * pi))

println("Absolute Error of the Output : ", absolute_error(val_1, val_2))
println("Relative Error of the Output : ", relative_error(val_1, val_2))
println()

# Well-Conditioned Example 
println("Well-Conditioned Example")

x2 = 0.1
eps = 1e-5

val_3 = cos(x2)
val_4 = cos(x2 + eps)

println("Absolute Error of the Input : ", absolute_error(x2, x2 + eps))
println("Relative Error of the Input : ", relative_error(x2, x2 + eps))

println("Absolute Error of the Output : ", absolute_error(val_3, val_4))
println("Relative Error of the Output : ", relative_error(val_3, val_4))
