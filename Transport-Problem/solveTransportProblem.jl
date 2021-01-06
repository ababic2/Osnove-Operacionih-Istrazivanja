function checkIfAnoterCustomerNeeded(C, Z, P)
   # imamo visak zaliha pa se dodaje fiktivni potrosac
   if (sum(Z)) > (sum(P))
      m = zeros(Int64, size(C,1), 1)
      C = hcat(C,m)
      difference = sum(Z) - sum(P)
      push!(P, difference)
      return C, P
   end
   return C, P
end

function checkIfAnoterWarehouseNeeded(C, Z, P)
   # imamo vise potreba pa se dodaje fiktivno skladiste
   if (sum(Z)) < (sum(P))
      m = zeros(Int64, size(C,2), 1)
      C = [C; m']
      difference = sum(P) - sum(Z)
      push!(Z, difference)
      return C, Z
   end
   return C, Z
end

function printResult(X, V)
   # Unfortunately Atom Juno from time to time is "eating" the first output line of a Julia script
   # The workaround that seems to work is to force a flush on the standard output cache:
      flush(stdout)
      println("X = ")
      show(stdout, "text/plain", X)
      println("\nV = \n", V)
end

function transport(C,Z,P)
   (C, P) = checkIfAnoterCustomerNeeded(C, Z, P)
   (C, Z) = checkIfAnoterWarehouseNeeded(C, Z, P)
   model = Model(GLPK.Optimizer)

   # ogranicenje na negativnost promjenljivih
   @variable(model, x[1:size(C,1),1:size(C,2)] >=0, Int)
   fn = @expression(model, sum(C.*x))

   # ogranicenje na potrebe prodavnice
      @constraint(model,constraint1[i=1:size(P,1)], sum(x[:,i]) == P[i])

   # ogranicenje na izvoz iz skladista
      @constraint(model, constraint2[i=1:size(Z,1)], sum(x[i,:]) == Z[i])

   @objective(model, Min, fn)
   status = JuMP.optimize!(model)
   X = value.(x)
   targetFn = objective_value(model)
   printResult(X, targetFn)
   return X, targetFn
end

function test1()
   flush(stdout)
   println("\nTEST 1")
   C=[3 2 10;5 8 12;4 10 5;7 15 10] #cijene
   S=[20, 50, 60, 10] #zalihe
   P=[20, 40, 30] #potrebe
   (X,V) = transport(C,S,P)
end

function test2()
   println("\nTEST 2")
   C=[8 18 16 9 10;10 12 10 3 15;12 15 7 16 4];
   S=[90, 50, 80];
   P=[30, 50, 40, 70, 30];
   (X,V) = transport(C,S,P)
end

function test3()
   println("\nTEST 3")
   C=[10 12 0;8 4 3;6 9 4;7 8 5];
   Z=[20, 30, 20, 10];
   P=[40, 10, 30];
   (X,V) = transport(C,S,P)
end

test1()
test2()
test3()
