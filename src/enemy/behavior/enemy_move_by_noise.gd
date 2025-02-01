class_name EnemyMoveByNoise
extends Node

@export var target: Enemy

@export var noise: FastNoiseLite
@export var amplitude: Vector2

@onready var viewport_rect: Rect2 = get_viewport().get_camera_2d().get_viewport_rect()

var t: float = 0.0


func _ready() -> void:
	noise = noise.duplicate()
	noise.seed = randi()


func _physics_process(delta: float) -> void:
	t += delta
	
	var tp: Vector2 = target.target_position
	var shrunk_rect: Rect2 = viewport_rect.grow(-1)
	if tp.x < viewport_rect.position.x or tp.x > viewport_rect.end.x:
		amplitude.x *= -1
		target.target_position = tp.clamp(shrunk_rect.position, shrunk_rect.end)
	if tp.y < viewport_rect.position.y or tp.y > viewport_rect.end.y:
		amplitude.y *= -1
		target.target_position = tp.clamp(shrunk_rect.position, shrunk_rect.end)
	
	target.velocity += Vector2(
		noise.get_noise_1d(t),
		noise.get_noise_1d(t + 1000)
	) * amplitude
