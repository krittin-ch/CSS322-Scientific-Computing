# Conditionals

#=
    if *condition 1*
        *option 1*
    elseif *condition 2*
        *option 2*
    else 
        *option 3*
    end

    OR

    if *condition 1* *option 1*
    elseif *condition 2* *option 2*
    else  *option 3*
    end

    OR

    if *condition 1* *option 1.1* ; *option 1.2*; ... 
    elseif *condition 2* *option 2*
    else  *option 3*
    end
=#

x = 3
y = 1

if x > y println("$x is greater than $y"); println("This is an extra line")
elseif x < y
    println("$x is smaller than $y")
else 
    println("$x and $y are equal")
end

println()

# Ternary Operator
#=
    *condition* ? *option 1* : *option 2*

    if *condition*
        *option 1*
    else 
        *option 2*
    end
=#

z = (x > y) ? x : y

println("The larger value is $z\n")

# Short-Circuit Evaluation

#=
    a && b : a AND b
    a || b : a OR b
=#

truth_value = (x > y) && (1 == 1)

println("The truth value is $truth_value")


(x > y) && println("$x is larger than $y\n")

(x < y) && println("$x is smaller than $y\n")
