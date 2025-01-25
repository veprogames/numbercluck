@icon("uid://du7f5tna07qmy")
class_name Player
extends Node2D

@onready var padding: Vector2 = ($Sprite2D as Sprite2D).texture.get_size() * 1.2
@onready var viewport_rect: Rect2 = get_viewport_rect()

var IonBullet: PackedScene = preload("res://src/bullet/ion_bullet.tscn")


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
	
	var click_event: InputEventMouseButton = event as InputEventMouseButton
	if click_event and click_event.pressed:
		var b: Bullet = IonBullet.instantiate() as Bullet
		b.global_position = global_position + Vector2.UP * 16
		owner.add_child(b)
