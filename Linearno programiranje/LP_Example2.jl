function primjer2()
    m = Model(GLPK.Optimizer)
    @variable(m, x1 >= 0)
    @variable(m, x2 >= 0)
    @objective(m, Max, 3x1 + 2x2)
    @constraint(m, constraint1, 0.5x1 + 0.25x2 <= 12)
    @constraint(m, constraint2, 500x1 - 200x2 <= 3000)
    print("\nMODEL:\n\n", m)
    optimize!(m)
    println("Termination status: " * string(termination_status(m)))
    println("Constraints values: ")
    println(value(constraint1))
    println(value(constraint2))
    s =
    "Rješenja su: " *
    "\n x1 = " *
    string(value(x1)) *
    "\n x2 = " *
    string(value(x2)) *
    "\nVrijednost cilja: " *
    string(objective_value(m))
    println(s)
end
primjer2()
