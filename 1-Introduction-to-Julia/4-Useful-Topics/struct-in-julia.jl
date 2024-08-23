struct MyObj
    field1
    field2
end

myObj1 = MyObj("Hello", "World")

# println(myObj1) # MyObj("Hello", "World")

# println(myObj1.field1)  # Hello

# myObj1.field1 = "test"  # ERROR: LoadError: setfield!: immutable struct of type MyObj cannot be changed

mutable struct Person 
    name::String
    age::Float64
    isActive        # better use `isActive::Bool` to ensure the data type

    function Person(name, age)
        new(name, age, true)
    end
end

logan = Person("Logan", 44)

# println(logan)  # Person("Logan", 44.0, true)

logan.age += 1

# println(logan)  # Person("Logan", 45.0, true)

# bob = Person(5, 20) # ERROR: LoadError: MethodError: Cannot `convert` an object of type Int64 to an object of type String

function birthday(person::Person)
    person.age += 1
end

birthday(logan)

println(logan)