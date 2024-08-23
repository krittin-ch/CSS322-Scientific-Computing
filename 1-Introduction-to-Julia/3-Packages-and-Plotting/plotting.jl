# using Pkg
# Pkg.add("Plots")

using Plots

output_dir = "Introduction-to-Julia/Packages-and-Plotting/"

x = -3:0.1:3

f(x) = x^2

y = f.(x)

# GR backend : the default backend for Plots
gr()

#=
plot_1 = plot(x, y, label="line", show=true)
scatter!(x, y, label="points")
=#

#=
    The `!` at the end of `scatter!` function makes `scatter!` a mutating function,
    indicating that the scatter points will be added onto the pre-existing plot.
=#

# png(plot_1, output_dir * "sample_plot")

global_temp = [14.4, 14.5, 14.8, 15.2, 15.5, 15.8]
num_pirates = [45000, 20000, 15000, 5000, 400, 17]

#=
plot_2 = plot(num_pirates, global_temp, legend=false, show==true)
scatter!(num_pirates, global_temp, legend=false)

xflip!()

xlabel!("Number of Pirates [Approximate]")
ylabel!("Global Temperature (C)")
title!("Influence of Pirate Population on Global Warming")

# png(plot_2, output_dir * "pirate")
=#

p1 = plot(x, x)
p2 = plot(x, x.^2)
p3 = plot(x, x.^3)
p4 = plot(x, x.^4)

plot_3 = plot(p1, p2, p3, p4, layout=(2, 2), legend=false)

png(plot_3, output_dir * "function")
