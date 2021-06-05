function zadatak2()
    m = Model(GLPK.Optimizer)
    @variable(m, x1 >= 0)
    @variable(m, x2 >= 0)
    @objective(m, Max, 150x1 + 40x2)
    @constraint(m, constraint1, 3x1 <= 36)
    @constraint(m, constraint2, 2x2 <= 54)
    @constraint(m, constraint3, 9x1 + 4x2 <=144)
    print("\nMODEL:\n\n", m)
    optimize!(m)
    println("Termination status: " * string(termination_status(m)))
    println("Constraints values: ")
    println(value(constraint1))
    println(value(constraint2))
    s =
    "Rješenja su: " *"\n x1 = " *
    string(value(x1)) *
    "\n x2 = " *
    string(value(x2)) *
    "\nVrijednost cilja: " *
    string(objective_value(m))
    println(s)
end
zadatak2()
