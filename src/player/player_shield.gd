class_name PlayerShield
extends Node2D

var t: float = 0

const ShieldTexture: Texture2D = preload("res://assets/player/shield.png")


func _process(delta: float) -> void:
	t += delta
	
	queue_redraw()
	
	if t >= 3:
		queue_free()


func _draw() -> void:
	draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE * (1 + 0.2 * sin(2 + t * TAU) + 0.001 * 16.0 ** t))
	draw_texture(ShieldTexture, -ShieldTexture.get_size() / 2, Color.WHITE * minf(1.0, 1.5 - t / 2))
