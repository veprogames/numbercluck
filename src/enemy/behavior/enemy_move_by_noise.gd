class_name EnemyMoveByNoise
extends Node

@export var target: Enemy

@export var noise: FastNoiseLite
@export var amplitude: float

var t: float = 0.0


func _ready() -> void:
	noise = noise.duplicate()
	noise.seed = randi()


func _physics_process(delta: float) -> void:
	t += delta
	target.target_position += Vector2(
		noise.get_noise_1d(t),
		noise.get_noise_1d(t + 1000)
	) * amplitude * delta
