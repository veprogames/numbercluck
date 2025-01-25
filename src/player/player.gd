@icon("uid://du7f5tna07qmy")
class_name Player
extends Node2D

@onready var padding: Vector2 = ($Sprite2D as Sprite2D).texture.get_size() * 1.2
@onready var viewport_rect: Rect2 = get_viewport_rect()

@onready var position0: Vector2 = global_position

var lives: int = 3


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _unhandled_input(event: InputEvent) -> void:
	var mouse_event: InputEventMouseMotion = event as InputEventMouseMotion
	if mouse_event:
		position += mouse_event.relative
		position = position.clamp(
			viewport_rect.position + padding / 2,
			viewport_rect.end - padding / 2
		)


func _on_damage_area_area_entered(area: Area2D) -> void:
	if area is Bullet or area is Enemy:
		position = position0
		lives -= 1
	
		if lives <= 0:
			queue_free()
