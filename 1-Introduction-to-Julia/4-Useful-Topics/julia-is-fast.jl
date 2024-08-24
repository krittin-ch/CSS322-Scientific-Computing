# How fast is Julia?

# Test with sum
a = rand(10^7)

# Sum with Julia
x1 = sum(a)

using Pkg

# Add and use BenchmarkTools for benchmarking
Pkg.add("BenchmarkTools")
using BenchmarkTools

# Add and use PyCall for Python interoperability
Pkg.add("PyCall")
using PyCall

# Add and use Conda for managing Python packages
Pkg.add("Conda")
using Conda

# Get Python's built-in sum function
pysum = pybuiltin("sum")

# Sum with Python's built-in sum
x2 = pysum(a)  # Directly pass the Julia array

# Check if the results are approximately equal
@assert pysum(a) ≈ sum(a)

# Benchmark Python's built-in sum
py_list_bench = @benchmark $pysum($a)

# Store the benchmark result in a dictionary
d = Dict{String, Float64}()
d["Python built-in"] = minimum(py_list_bench).time / 1e6

# Use Conda to add numpy if not already installed
Conda.add("numpy")
numpy_sum = pyimport("numpy")["sum"]

# Sum with numpy's sum
x3 = numpy_sum(a)  # Directly pass the Julia array

# Check if the results are approximately equal
@assert numpy_sum(a) ≈ sum(a)

# Benchmark numpy's sum
py_numpy_bench = @benchmark $numpy_sum($a)
d["Python numpy"] = minimum(py_numpy_bench).time / 1e6

# Python (hand-written)
py"""
def py_sum(a):
    s = 0.0
    for i in a:
        s += i
    return s
"""

sum_py = py"py_sum"

py_hand = @benchmark $sum_py($a)

@assert sum_py(a) ≈ sum(a)

d["Python hand-written"] = minimum(py_hand).time / 1e6

# Julia (built-in)
j_bench = @benchmark sum($a)

d["Julia built-in"] = minimum(j_bench).time / 1e6

# Julia (hand-written)
function mySum(A)
    s = 0.0
    for a in A
        s += a 
    end

    return s
end

j_bench_hand = @benchmark mySum($a)

d["Julia hand-written"] = minimum(j_bench_hand).time / 1e6

# Summary
# for (key, value) in sort(collect(d))
#     println(rpad(key, 20, "."), lpad(round(value, 1), 8, "."))
# end
    
display(d)

println(d)