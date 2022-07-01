# the next line imports a Python mathematics library- https://numpy.org/
import numpy as np

def displayMatrix():
    print("\033c")
    for row in range(len(A)):
        print(A[row], end = "  ")
        print(alphabet[row], end = " = ")
        print(B[row])
    return


# get the number of unknowns to be solved
number = int(input('Enter number of unknowns: '))
# matrix A (n x n square matrix) to contain the simultaneous equation co-efficients)
# matrix B (1 x n matrix) to contain the constants
A, B = [], []
for _ in range(number):
    A.append([])
    B.append([])
# the names of the variables (n can be up to the length of alphabet)
alphabet = [
    'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
    'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
]
displayMatrix()
# get the co-efficients for the input equations to be solved
for row in range(number):
    for column in range(number):
        A[row].append(
            float(
                eval(
                    input(
                        'Enter co-efficient of "{}" for equation {}: '.format(
                            alphabet[column], row + 1)))))
        displayMatrix()
    B[row].append(
        float(
            eval(
                input('Enter answer constant for equation {}: '.format(row +
                                                                       1)))))
    displayMatrix()

# store the inputs into matrices
matA, matB = np.matrix(A), np.matrix(B)
# solve the simultaneouse equations using matrix inversion method
try:
    print()
    Answer = matA.I * matB
    # print the output
    for x in range(number):
        print('{} = {}     '.format(str(alphabet[x]), Answer[x]), end='')
except:
    print(
        'Something went wrong with your equations (probably the equations are not linearly independent)'
    )
