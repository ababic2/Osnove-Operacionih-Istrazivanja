function zadatak3()
    m = Model(GLPK.Optimizer)
    @variable(m, x1 >= 0)
    @variable(m, x2 >= 0)
    @variable(m, x3 >= 0)
    @objective(m, Max, 2x1 + 3x2 + x3)
    @constraint(m, constraint1, 2x1 + 2x2 + 2x3 <= 4)
    @constraint(m, constraint2, 3x1 + 3x2 <= 2)
    @constraint(m, constraint3, x2 + x3 <= 3)
    print("\nMODEL:\n\n", m)
    optimize!(m)
    println("Termination status: " *
    string(termination_status(m)))
    println("Constraints values: ")
    println(value(constraint1))
    println(value(constraint2))
    println(value(constraint3))
    s =
    "Rješenja su: " *
    "\n x1 = " *
    string(value(x1)) *"\n x2 = " *
    string(value(x2)) *
    "\n x3 = " *
    string(value(x3)) *
    "\nVrijednost cilja: " *
    string(objective_value(m))
    println(s)
end
zadatak3()
