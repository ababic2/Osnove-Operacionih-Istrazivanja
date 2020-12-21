function subMinInRows(A)
  for i = 1 : size(A,1)
    min = minimum(A[i:i,:]);
    A[i:i,:].-=min;
  end
end

function subMinInCols(A)
  for i = 1 : size(A,2)
    min = minimum(A[:,i:i]);
    A[:,i:i].-=min;
  end
end

function findRowsWithOneZero(A)
  result = Any[]
  for i = 1 : size(A,1)
    broj = count(z->(z == 0), A[i:i,:])
    if broj == 1
      # return i
      push!(result,i)
    end
  end
  return result
end

function findColIndex(A, zeroRows)
  for i = 1 : size(A,2)
    if A[zeroRows, i] == 0
      A[zeroRows, i] = -1
      return i
    end
  end
end

function setDependentZerosInColumn(A, col)
  for i = 1 : size(A, 1)
    if A[i, col] == 0
      A[i, col] = -2
    end
  end
end

function findColsWithOneZero(A)
  result = Any[]
  for i = 1 : size(A,2)
    broj = count(z->(z == 0), A[:, i:i])
    if broj == 1
      # return i
      push!(result, i)
    end
  end
  return result
end

function findRowIndex(A, zeroCols)
  for i = 1 : size(A,1)
    if A[i, zeroCols] == 0
      A[i, zeroCols] = -1
      return i
    end
  end
end

function setDependentZerosInRow(A, row)
  for i = 1 : size(A, 2)
    if A[row, i] == 0
      A[row, i] = -2
    end
  end
end

function rasporedi(M)
  println("ULAZIM")

A = copy(M)

#oduzimanje najmanjeg kroz redove
subMinInRows(A)

#oduzimanje najmanjeg kroz kolone
subMinInCols(A)

#pronalazak redova koji imaju samo jednu nulu
zeroRows = findRowsWithOneZero(A)
while length(zeroRows) != 0

  #nakon sto je pronadjena kolona, trazmo indeks reda i nezavisnu nulu postavljamo na -1
  rowIndex = findColIndex(A, zeroRows[1])

  #oznacavanje zavisnih nula u redu sa -2
  setDependentZerosInColumn(A, rowIndex)
  zeroRows = findRowsWithOneZero(A)
end

#pronalazak kolona koje imaju samo jednu nulu
zeroCols = findColsWithOneZero(A)
while length(zeroCols) != 0

  #nakon sto je pronadjena kolona, trazmo indeks reda i nezavisnu nulu postavljamo na -1
  rowIndex = findRowIndex(A, zeroCols[1])

  #oznacavanje zavisnih nula u redu sa -2
  setDependentZerosInRow(A, rowIndex)
  zeroCols = findColsWithOneZero(A)
end


display("text/plain",M);
display("text/plain",A);
end

M = [80 20 23; 31 40 12; 61 1 1]
rasporedi(M)

N = [25 55 40 80; 75 40 60 95; 35 50 120 80; 15 30 55 65]
rasporedi(N)
