# Ill-Condition Example

#=
    Find the root of x^2 - 2x + 1 = 0

        As a = 1, b = -2, c = 1, the root are -b ± √(b^2 -4ac) / 2a = 1 and 1

        Hence the root of the equation is x =1

    Suppose c is perturbed to 1 - δ, where δ > 0 and is very small

        The root of x^2 - 2x + (1 - δ) = 0 are 1 ± √δ

        The relative change of the input is 
            |(1 - δ) - 1| / |1| = δ

        The relative change of the solution is
            |(1 ± √δ) - 1| / |1| = √δ

        Therefore, it is ill-conditioned because, for example, δ = 10^=16 then √δ = 10^-8
        which results a large change in the solution compared to the change in the input

    Unlike this equation, x^2 - 3x + 1 = 0 is well-conditioned
=#