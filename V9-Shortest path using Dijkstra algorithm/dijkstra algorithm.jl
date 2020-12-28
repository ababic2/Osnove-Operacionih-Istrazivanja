function findMinInRow(A, i)
    min = 0
    indeks = 0
    for j = 3 : size(A,2)
        if min == 0 && A[i,j] != 0 && A[i,j] != -1
            min = A[i,j]
            indeks = j
        end
        if A[i,j] < min && A[i,j] != 0 && A[i,j] != -1
            min = A[i,j]
            indeks = j
        end
    end
    return min, indeks - 2
end

function setInitialNode(A, first)
    A[1,1] = first
    A[1,2] = 0
    for i = 3 : size(A,2)
        A[1, i] = M[first, i - 2]
    end
end

function setNode(A, M, tezina, indeks, red)
    A[red, 1] = indeks
    A[red, 2] = tezina
    for i = 3 : size(A,2)
        if i == indeks + 2
            A[red, i] = -1
        elseif A[red - 1, i] == 0 && M[indeks, i - 2 ] != 0
            A[red, i] =  M[indeks, i - 2] + tezina
        elseif A[red - 1, i] != 0 && M[indeks, i - 2] != 0 && A[red - 1, i] > M[indeks, i - 2] + tezina
            A[red, i] =  M[indeks, i - 2] + tezina
        else
            A[red, i] =  A[red - 1,i]
        end
    end
end

function pronadji_puteve(A, numberOfNonZeroRows)

    putevi = zeros(Int64, numberOfNonZeroRows, 3)
    for i = 1 : numberOfNonZeroRows
        putevi[i, 1] = A[i, 1]
        putevi[i, 2] = A[i, 2]
        if i == 1
            putevi[i, 3] = A[1, 1]
        else
            putevi[i, 3] = A[i - 1, 1]
        end
    end
    return putevi
end

function najkraci_put(M, first)
    A = zeros(Int8, size(M,1), size(M,2) + 2)
    setInitialNode(A, first)
    (min, indeks) = findMinInRow(A,1)
    numberOfNonZeroRows = 1
 for i = 2 : size(M,2)
     if indeks < 0
         break;
     end
    numberOfNonZeroRows = numberOfNonZeroRows + 1
    setNode(A, M, min, indeks, i)
    (min, indeks) = findMinInRow(A,i)
 end
 display(A)
 return pronadji_puteve(A, numberOfNonZeroRows)
end

M = [0 3 7 4 0 0 ; 0 0 1 0 1 0; 0 0 0 0 2 3; 0 0 1 0 0 5; 0 0 0 0 0 1; 0 0 0 0 0 0];
M = [0 6 2 0 0 0; 0 0 3 3 0 0; 0 5 0 0 1 0; 0 0 4 0 0 3; 0 1 0 0 0 2; 0 6 2 0 0 0];
first = 1;
putevi = najkraci_put(M, first);
display(putevi)
