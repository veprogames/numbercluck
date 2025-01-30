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
	var value: Variant = expression.execute([x])
	if value is float:
		return value
	return 0.0
