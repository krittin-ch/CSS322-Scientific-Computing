# Vector Norms

#=
    ||.|| is a norm if
        
        1. ||x|| >= 0 for all x is a member of R^n. ||x|| = 0 if and only if x = 0.
        
        2. If α is a scalar,
            ||αx|| = |α|*||x||

        3. For all x, y are members of R^n,
            ||x + y|| <= ||x|| + ||y||

            which is known as "Triangular Inequality."

    2-Norm :
        ||x||_2 = sqrt(Σ_i=1_n of (x_i)^2) = sqrt(x^T * x)

        Also known as "Euclidean norm"
        
    1-Norm :    
        ||x||_1 = Σ_i=1_n of |x_i|

    ∞-norm :
        ||x||_∞ = max_i=1_n {|x_i|}

    p_norm :
        ||x||_p = (|x_1|^p + |x_2|^p + |x_3|^p + . . . + |x_n|^p)^1/p

        The 1-, 2- and ∞-norms are actually p-norms
=#

function two_norm(v::Vector)
    return sqrt(transpose(v) * v)
end

function one_norm(v::Vector)
    return sum(abs.(v))
end

function inf_norm(v::Vector)
    return max(abs.(v)...)
end

function p_norm(v::Vector, p)
    if p < 1
        print("ERROR p shold be greater or equal to 1")
        return -1
    end
    
    p = convert(Float64, p)

    return sum(abs.(v).^p)^(1/p)
end

v = Vector{Float64}([1; -2; 0; 4])

println("1-norm of vector v : ", one_norm(v))
println("2-norm of vector v : ", two_norm(v))
println("∞-norm of vector v : ", inf_norm(v))

p = 8
println("p-norm (p = $p) of vector v : ", p_norm(v, p))
