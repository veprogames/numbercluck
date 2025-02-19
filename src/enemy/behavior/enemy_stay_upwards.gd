class_name EnemyStayUpwards
extends Node


@export var target: Enemy
@export var y: float
@export var speed: float

@onready var viewport_rect: Rect2 = target.get_viewport_rect()


func _physics_process(_delta: float) -> void:
	var enemy_y: float = (target.position.y - viewport_rect.position.y) / viewport_rect.size.y
	var current_speed: float = remap(enemy_y, y, 1.0, 0.0, speed)
	current_speed = clampf(current_speed, 0.0, speed)
	target.velocity += Vector2.UP * current_speed
