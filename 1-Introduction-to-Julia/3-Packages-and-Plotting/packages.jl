using Pkg

include("example.jl")

using .HelloWho

x = hello("Tin")

println(x)

#=    
    Julia Command Line Modes

    Standard mode   : The default mode where you can enter and execute Julia code.
    Pkg mode        : Accessed by pressing ], this mode is used to manage Julia packages.
    Shell mode      : Accessed by pressing ;, this mode allows you to run shell commands.
    Help mode       : Accessed by pressing ?, this mode provides documentation and help for functions and commands.

    To exit the Pkg REPL, press `backspace` or `delete`     
=#
Pkg.add("Example")