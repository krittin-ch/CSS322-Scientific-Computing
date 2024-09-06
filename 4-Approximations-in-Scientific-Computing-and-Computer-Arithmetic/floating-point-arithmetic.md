# Floating Point Arithmetic

    Computers represent real numbers by a floating-point number system. Usualy in base 2.

    Floating-point number system : ± (d_0 . d_1 d_2 . . . d_n)_2 × 2^E      (There is a dot between d_0 and d_1)

    p is the number of mantissa digits (precision), E is the (integer) exponent (L ≤ E ≤ U), d_i is either 0 or 1.

    E.g., 
        3 = (1.1)_2 × 2^1
        0.5 = (1.0)_2 × 2^-1
        10 = (1.01)_2 × 2^3

    For example, the `double` variable in JAVA
        p = 53, L = -1022, U = 1023

    Many minor adjustments such as d_0 is assumes to always be 1, so it is not stored, 
    using bias of 1023 for the exponent, special values for 0, infinty, and NaN (Not-a-Number).

        Bias of 1023 for the exponent : 
            (00000000001)_2 = -1022,
            (00000000001)_2 = -1021,
                            .
                            .
                            .
            (11111111110)_2 = 1023,

        (00000000000)_1 and (11111111111)_2 are reserved for special values.

    Specifically, one `double` variable is 84 bits: 1 bit for sign, 11 bits for the exponent, and 52 bits for the mantissa.



Unit Roundoff :

    Unit roundoff, or machine epsilon, is the maximum possible relative error resulting from one scalar operation in floating-point arithmetic.
    
    Denote as ϵ_mach.

    If the digits that cannot be stored are simply chopped off,
        ϵ_mach = 2^(1 - p)

    If rounding the nearest. In case of tie, round to the number whose last stored digit is 0,
        ϵ_mach = 2^-p 

    For IEEE `double-type` variables, ϵ_mach = 2^-52 ≈ 2.2 × 10^-16