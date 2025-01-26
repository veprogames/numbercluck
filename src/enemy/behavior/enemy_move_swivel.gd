class_name EnemyMoveSwivel
extends Node

@export var target: Enemy

@export var amplitude: Vector2
@export var period: Vector2

var t: float = randf() * 10


func _physics_process(delta: float) -> void:
	t += delta
	target.velocity += Vector2(
		0.0 if period.x <= 0 else amplitude.x * cos(t * TAU / period.x),
		0.0 if period.y <= 0 else amplitude.y * sin(t * TAU / period.y)
	)
