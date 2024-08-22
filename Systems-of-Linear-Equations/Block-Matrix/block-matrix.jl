# Define the smaller matrices
A = [1 2; 6 7]      # 2x2 matrix
B = [3 4 5; 8 9 10] # 2x3 matrix
C = [11 12]         # 1x2 matrix
D = [13 14 15]      # 1x3 matrix

# Create the block matrix
M1 = [A B; C D]
M2 = [C D; A B]

println(M1)
