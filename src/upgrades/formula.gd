class_name Formula
extends Resource

@export var formula: String :
	set(f):
		formula = f
		var error: Error = expression.parse(formula, ["x"])
		if error != OK:
			print(error)

var expression: Expression = Expression.new()


func get_value(x: float) -> float:
	var value: Variant = expression.execute([x], self)
	if value is float:
		return value
	return 0.0


func rm(num: float) -> float:
	var factor: float = 10.0 ** (int(log(num) / log(10)) - 1)
	return roundf(num / factor) * factor
