function primjer3()
    m = Model(GLPK.Optimizer)
    @variable(m, x1 >= 0)
    @variable(m, x2 >= 0)
    @objective(m, Min, 40x1 + 30x2)
    @constraint(m, constraint1, 0.1x1 >= 0.2)
    @constraint(m, constraint2, 0.1x2 >= 0.3)
    @constraint(m, constraint3, 0.5x1 + 0.3x2 >=3)
    @constraint(m, constraint4, 0.1x1 + 0.2x2 >= 1.2)
    print("\nMODEL:\n\n", m)
    optimize!(m)
    println("Termination status: " * string(termination_status(m)))
    println("Constraints values: ")
    println(value(constraint1))
    println(value(constraint2))
    println(value(constraint3))
    println(value(constraint4))
    s =
    "Rješenja su: " *
    "\n x1 = " *
    string(value(x1)) *
    "\n x2 = " *string(value(x2)) *
    "\nVrijednost cilja: " *
    string(objective_value(m))
    println(s)
end
primjer3()
