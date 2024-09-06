# Big-Oh Notation for Small Variables 

Example : 

    Consider
        f(n) = 4n^4 + 3n^3 - n^2 + 9n 

    When n >> 1, 
        f(n) = O(n^4)

    When 0 < n << 1, 
        Since n > n^2 > n^3 > n^4, f(n) = O(n)

In general,

    When n >> 1, 
        O(n^p) = c_p * n^p + c_{p-1} * n^{p-1} + . . . + c_0

    When 0 < h << 1,
        O(h^p) = c_p * h^p + c_{p-1} * h^{p+1} + . . .

    Conventionally, h is used for small value.
    