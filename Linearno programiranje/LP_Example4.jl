function zadatak1()
    m = Model(GLPK.Optimizer)
    @variable(m, x1 >= 0)
    @variable(m, x2 >= 0)
    @objective(m, Max, 2x1 + 4x2)
    @constraint(m, constraint1, x1 <= 3)
    @constraint(m, constraint2, x2 <= 6)
    @constraint(m, constraint3, 3x1 + 2x2 <=18)
    print("\nMODEL:\n\n", m)
    optimize!(m)
    println("Termination status: " * string(termination_status(m)))
    println("Constraints values: ")
    println(value(constraint1))
    println(value(constraint2))
    s ="Rješenja su: " *
    "\n x1 = " *
    string(value(x1)) *
    "\n x2 = " *
    string(value(x2)) *
    "\nVrijednost cilja: " *
    string(objective_value(m))
    println(s)
end
zadatak1()
