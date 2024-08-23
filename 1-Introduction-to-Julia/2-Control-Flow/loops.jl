# while loop

#=
    while *condition*
        *loop body*
    end
=#

n = 0

while n < 10
    println("n = ", n)
    global n += 1
end

println()

myFriends = ["Ted", "Robyn", "Barney", "Lily", "Marshall"]

i = 1

while i <= length(myFriends)
    friend = myFriends[i]
    println("Hi $friend, it's great to see you!")
    global i += 1
end

println()


# for loops

#=
    for *var* in *loop iterable*
        *loop body*
    end
=#

for n in 1:15
    println("n = ", n)
end

println()

println("global n = ", n)
println()

for friend in myFriends
    println("Hi $friend, it's great to see you!")
end

println()

# Matrix
m, n = 5, 5
A = zeros(m, n)

for i in 1:m
    for j in 1:n
        A[i, j] = i + j
    end
end

println("A = ", A)
println()

B = zeros(m, n)

for i in 1:m, j in 1:n
    B[i, j] = i + j
end

println("B = ", B)
println()

C = [i + j for i in 1:m, j in 1:n]

println("B = ", C)
println()

display(C)

for n in 1:10
    A = [i + j for i in 1:n, j in 1:n]
    display(A)  # local variable
end

display(A)  # global variable