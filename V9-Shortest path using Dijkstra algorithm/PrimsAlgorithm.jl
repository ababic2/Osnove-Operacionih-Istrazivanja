function setZeros(A)
    for i = 1 : size(A, 1)
        for j = 1 : size(A, 2)
            A[i,j] = (0,0)
        end
    end
end

function setFirstRow(A, M)
    for i = 1 : size(M,2)
        if i != 1
            A[1,i] = (M[1,i], 1)
        end
    end
end

function findMinInRow(A, row)
    min = A[row, 2][1] #prvi tuple
    nextElement = 2

    for i = 2 : size(A, 2)
        if (A[row,i][1] < min && A[row,i] != (-1,-1) && A[row,i] != (0,0)) || min < 0
            min = A[row,i][1] #min element reda
            nextElement = i #sljedeci red
        end
    end
    #postavi na -1 citavu tu kolonu
    for i = row + 1 : size(M,2)
        A[i, nextElement] = (-1,-1)
    end
    return min, nextElement
end

function setRow(A, M, next, row)
    col = 1
    for j = 2 : size(M,2)
            if M[next,j]!=0 && (A[row - 1, j][1] != 0 && A[row - 1, j][1] < M[next ,j] && A[row, j] != (-1,-1))
                A[row, j] = A[row-1,j]
                col = A[row, j][2]
            elseif M[next,j]!=0 && (A[row - 1, j][1] == 0 || A[row - 1, j][1] > M[next ,j] )
                A[row , j] =  (M[next, j], next)
                col = next
            elseif M[next,j]==0 && A[row, j] != (-1,-1)
                A[row, j] = A[row-1,j]
                col = A[row, j][2]
            end
    end
    return col
end
function setMatrixAndBranches(A, M)
    branches = zeros(Int64, size(M,1) - 1, 3)
    setFirstRow(A, M)
    (weight, next) = findMinInRow(A, 1)
    branches[1,1] = 1
    branches[1,2] = next
    branches[1,3] = weight
    Z = weight
    for i = 2 : size(M, 2)
        col = setRow(A, M, next, i) #postavi drugi red
        (weight, next) = findMinInRow(A, i)
        if i != size(M,2)
            branches[i,1] = col
            branches[i,2] = next
            branches[i,3] = weight
            Z = Z + weight
        end
    end
    return branches, Z
end


function nadji_MST(M)
    A = Matrix{Tuple{Int64,Int64}}(undef, size(M, 1), size(M, 2))
    setZeros(A)
    (branches,Z) = setMatrixAndBranches(A, M)
    display(A)
    return branches, Z
end

M = [0 3 7 3 2; 3 0 6 8 5; 7 6 0 10 0; 3 8 10 0 4; 2 5 0 4 0; ];
(grane, Z) = nadji_MST(M);
println(Z)
display(grane)
