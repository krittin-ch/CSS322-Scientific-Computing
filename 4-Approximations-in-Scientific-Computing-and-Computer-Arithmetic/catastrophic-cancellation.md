# Catastrophic Cancellation
## THE SECOND MOST IMPORTANT POINT IN THE COURSE!

Catastrophic Cancellation :

    Consider substracting two numbers having the same sign and similar magnitude such that the result has much smaller magnitude.

    For example, x_hat = 150422 and y_hat = 150419,
        z_hat = x_hat - y_hat = 150422 - 150419 = 3

        However, x_hat and y_hat are likely to be approximations, e.g., from previous computation or measurement.

        Suppose x_hat is the approximation of x = 150421,
        and y_hat is the approximation of y = 150420.

        The true difference is z = x - y = 150421 - 150420 = 1.

        The relative error of the output is 
            |z_hat - z| / |z| = |3 - 1| / |1| = 2

        The relative errors of the inputs are 
            |x_hat - x| / |x| = |150422 - 150421| / |150421| = 1 / 150421

            |y_hat - y| / |y| = |150419 - 150420| / |150420| = 1 / 150420

            which are much smaller than the relative error of the output.


    Subtracting two numbers having the same sign and similar magnitude 
    such that the result has much smaller magnitude can result in very large error.

    Intuitively, this is because the absolute error of the result is about the same magnitude as the absolute errors of the two numbers, 
    but the true value of the result is much smaller in magnitude than the true values of the two numbers,

    Hence we have very high relative error in the result.

    Multiplication, division, and addition of two numbers having the same sign are “safe”.



Note: If you have catastrophic cancellation in the middle of your computation, 
your final result may or may not have large relative error, however! (It depends on subsequent operations.)

Examples:
    1/x has about the same relative error as that of x.
    
    If x is about 1, then x + 1000 has much smaller relative error than that of x.