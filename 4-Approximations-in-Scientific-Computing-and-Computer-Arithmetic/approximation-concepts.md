# Approximation Concepts

Sources of approximations before computation begins

    1. Modeling
        Some physical features of the problem or system under study 
        may be simplified or omitted (e.g., friction, viscosity, resistance)

    2. Empirical Measurement
        Instruments for measurement have finite precision.
        Small sample size.
        Random noise during measurement.

    3. Previous Computations
        Input may be produced by a previous computation, whose results were only approximate. 

Sources of approximations during computation

    1. Trucnaation and Discretization
        Using a finite number of terms in an infinite series.
            Example :
                exp(x) = 1 + x/1! + x^2/2! + . . . 

        Replcing derivatives by finite differences (which is only approximation of true derivatives).

    2. Rounding
        Floating-point variables can store finite amount of precision. So results of arithmetic operatins must be rounded.

        Exact arithmetic is possible but very slow, so it cannot be used for large problem.


While each of these approximations may be small,the error may be amplified by 
the nature of the problem being solved or the algorithm being used, or both.

Types of Errors

    Absolute Error = |approximate value - true value|

    Relative = absolute error / true value
