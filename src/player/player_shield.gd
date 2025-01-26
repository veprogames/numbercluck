class_name PlayerShield
extends Node2D

var t: float = 0


func _process(delta: float) -> void:
	t += delta
	
	queue_redraw()
	
	if t >= 3:
		queue_free()


func _draw() -> void:
	draw_circle(Vector2.ZERO, 100 + 20 * sin(2 + t * TAU) + 16.0 ** t, Color.WHITE, false, 3.0)
	draw_circle(Vector2.ZERO, 100 + 20 * sin(t * TAU) + 16.0 ** t, Color.WHITE, false, 3.0)
