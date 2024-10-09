# Alternative Methods

#=
    Interpolate f and find the derivative of the interpolant
        1. Let f: R -> R be the function whose derivatives we want to find
        2. Let t_i, i = 1, . . ., n be equally spaced points in R, with step size h = t_{i+1} - t_i 
        3. Let y_i = f(t_i)
        4. Let's interpolate two points (t_i, y_i) and (t_{i+1}, y_{i+1})
        
        The Lagrange interpolant of the two points is 
            p(t) = y_i * (t - t_{i+1})/(t_i - t_{i+1}) + y_{i+1} * (t - t_i)/(t_{i+1} - t_i)
                 = y_{i+1} * (t - t_i)/h - y_i * (t - t_{i+1})/h

        Take the derivative of p(t) with respect to t:
            p'(t) = y_{i+1}/h - y_i/h = (f(t_i + h) - f(t_i))/h

            which is the forward difference formula for f'

        Interpolating two points (t_{i-1}, y_{i-1}) and (t_i, y_i)
            p(t) = y_i * (t - t_{i-1})/h - y_{i-1} * (t - t_i)/h

            p'(t) = y_i/h - y_{i-1}/h = (f(t_i) - f(t_i - h))/h

            which is the backward difference formula for f'

        Interpolating three points (t_{i-1}, y_{i-1}), (t_i, y_i), and (t_{i+1}, y_{i+1})
            p(t) = y_{i-1} * ((t - t_i)(t - t_{i+1}))/(2h^2)
                 - y_i * ((t - t_{i-1})(t - t_{i+1}))/(h^2)
                 + y_{i+1} * ((t - t_{i-1})(t - t_i))/(2h^2)

            p'(t) = y_{i+1}/(2h) - y_{i-1}/(2h) = (f(t_i + h) - f(t_i - h))/(2h)

            which is the centered difference formula for f'

        And,
            p''(t) = (y_{i-1} - 2y_i + y_{i+1})/(h^2) = (f(t_i + h) - 2f(t_i) + f(t_i - h))/(h^2)

            which is the centered difference formula for f''
=#