#=
Differentiation

    Problem: Given f: R -> R, evaluate f'(x) for a given input x.
    Similar to integration, finding thee derivative anlaytically is expensive

    Goal: Approximate f'(x) for a given input x numerically without computing the formula for f'

Finite Difference 

    Let f: R -> R
    By Taylor series:
         f(x + h) = f(x) + f'(x) * h + f''(x)/2! * h^2 + f'''(x)/3! * h^3 + . . .
        f'(x) * h = f(x + h) - f(x) - f''(x)/2! * h^2 - f'''(x)/3! * h^3 + . . .
            f'(x) = (f(x + h) - f(x))/h - f''(x)/2 * h - . . .

          ∴ f'(x) = (f(x + h) - f(x))/h + O(h)

    Forward Difference: f'(x) ≈ (f(x + h) - f(x))/h
    This has first-order accuracy (error is O(h))

    Also,
         f(x - h) = f(x) - f'(x) * h + f''(x)/2! * h^2 - f'''(x)/3! * h^3 + . . .
        f'(x) * h = f(x) - f(x - h) + f''(x)/2! * h^2 - f'''(x)/3! * h^3 + . . .
            f'(x) = (f(x) - f(x - h))/h + f''(x)/2 * h - . . .

          ∴ f'(x) = (f(x) - f(x - h))/h + O(h)

    Backward Difference: f'(x) ≈ (f(x) - f(x - h))/h
    This has first-order accuracy (error is O(h))

    With substraction,
         f(x + h) -f(x - h) = 2f'(x) * h + 2f''(x)/3! * h^3 + . . .
        2f'(x) * h = f(x + h) - f(x - h) - f'''(x)/3 * h^3 + . . .
            f'(x) = (f(x + h) - f(x - h))/(2h) - f'''(x)/6 * h^3 + . . .

          ∴ f'(x) = (f(x + h) - f(x - h))/(2h) + O(h^2)

    Centered Difference: f'(x) ≈ (f(x) - f(x - h))/(2h)
    This has second-order accuracy (error is O(2h))
=#