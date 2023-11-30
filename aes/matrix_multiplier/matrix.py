import numpy as np



def hex_matrix(matrix):
    hex_matrix = []
    for i in range(len(matrix)):
        hex_matrix.append([])
        for j in range(len(matrix[i])):
            hex_matrix[i].append(hex(matrix[i][j]))
    return hex_matrix

def dec_matrix(matrix):
    dec_matrix = []
    for i in range(len(matrix)):
        dec_matrix.append([])
        for j in range(len(matrix[i])):
            dec_matrix[i].append(int(str(matrix[i][j]), 16))
    return dec_matrix

matrix = np.array([[2,3,1,1], [1,2,3,1], [1,1,2,3], [3,1,1,2]])
matrix_hex = np.array([[63,63,63,63],[2,2,2,2],[63,63,63,63],[2,2,2,2]])

print(dec_matrix(matrix_hex))

matrix_dec = dec_matrix(matrix_hex)

print(hex_matrix(np.multiply(matrix, matrix_dec)))