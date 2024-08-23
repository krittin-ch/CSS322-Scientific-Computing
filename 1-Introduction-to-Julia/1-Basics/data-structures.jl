# Dictionaries
myPhoneBook = Dict("Jenny" => 1, "John" => "123")

println("Original Phone Book = ", myPhoneBook)
println("type of myPhoneBook = ", typeof(myPhoneBook))

# Add another key and value
myPhoneBook["Kramer"] = "555-FILK"

println("Updated Phone Book = ", myPhoneBook)

# Delete key and value
pop!(myPhoneBook, "Kramer")

println("Phone Book After Pop = ", myPhoneBook)

name = "Jenny"
println("$name's phone number = ", myPhoneBook[name])
println()

# Tuples
zoo = ("penguins", "cats", "dogs")

println("zoo Contains ", zoo)
println("type of zoo = ", typeof(zoo))

println("First Index of zoo = ", zoo[1])

# tuples are immutable (cannot be modified)
# zoo[1] = "otters"
println()

# Arrays
myFriends = ["Ted", "Robyn", "Barney", "Lily", "Marshall"]

println("Firends = ", myFriends)
println("type of myFriiends = ", typeof(myFriends))
println()
fibonacci = [1, 1, 2, 3, 5, 8]
println("Fibonacci Sequence = ", fibonacci)
println("type of fibonacci = ", typeof(fibonacci))
println()

mix = [1, 2, 3, "Hi"]
println("Mix Array = ", mix)
println("type of mix = ", typeof(mix))
println()

fibonacci_size = size(fibonacci)[1]
println("Fibonacci Size = ", fibonacci_size)
# push! can add one or more items at the end of a collection
push!(fibonacci, fibonacci[fibonacci_size] + fibonacci[fibonacci_size - 1], 1000)
println("Updated Fibonacci Sequence = ", fibonacci)

lastVal = pop!(fibonacci)
println("Last Value = ", lastVal)
println()

favorites = [
    ["chocolate", "cocoa", "cocoalate"],
    ["chocolate bar", "chocolate granola", "chocolate ice cream"]
]

println("favorites = ", favorites)
println("type of favorites = ", typeof(favorites))

nums = [
    [1, 2, 3],
    [4, 5],
    [7, 8, "9"]
]

println("nums = ", nums)
println("type of nums = ", typeof(nums))
println()

rand_matrix = rand(4, 3, 2)

println("random matrix = ")
println(rand_matrix)
