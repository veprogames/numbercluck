class_name FirepowerTrail
extends Line2D

@export var color: Color :
	set(col):
		color = col
		if not is_node_ready():
			await ready
		modulate = col

var t: float = 0.0


func _ready() -> void:
	for i: int in range(30):
		add_point(Vector2.ZERO)


func _process(delta: float) -> void:
	t += TAU * delta
	for i: int in range(points.size()):
		var t1: float = t - i * 0.08
		points[i] = Vector2(cos(-t1), sin(-t1)) * Vector2(24, 6)
