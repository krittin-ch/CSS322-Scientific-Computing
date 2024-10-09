# Richardsson Extrapolation

#=
    Richardsson Extrapolation
        
        Let F(h) denote the value obtained from a given method with step size h
            For example, the value obtained from a finite difference method using step size h

        Suppose F(h) = a_0 + a_1 * h^p + O(h^r)
        as h -> 0 for some p and r, with r > p

        Assume we know the values of p (and r), but not a_0 or a_1 
        
        See that a_0 is the true value that we want to find (the true derivatibe, for instance) and p is the order of the formula F

        Suppose we compute F for two step sizes, for example, h and h/q for some positive integer q

        So we have
            F(h) = a_0 + a_1 * h^p + O(h^r)
        and 
            F(h/q) = a_0 + a_1 * (h/q)^p + O(h^r)
            F(h/q) = a_0 + a_1 * q^-p * h^p  + O(h^r)

        A system of two linear equations in two unknowns a_0 and a_1! --> solve for a_0 

            a_0 = F(h) + (F(h) - F(h/q))/(q^-p - 1) + O(h^r)
                ≈ F(h) + (F(h) - F(h/q))/(q^-p - 1)

        If F(h) is known for several values of h, can repeat the extrapolation process to get even more accurate approximations
=#

f(x) = sin(x)

function Richardson_extrapolation(f, x, h, q)
    F_1 = (f(x + h) - f(x))/h 
    F_2 = (f(x + h/q) - f(x))/(h/q)
    a_0 = F_1 + (F_1 - F_2)/(q^-1 - 1)

    return a_0
end

a_0 = Richardson_extrapolation(f, 1, 0.5, 2)

println("Richardson Extrapolation (Derivative of f(x) = sin(x) at x = 1 rad): ", a_0)