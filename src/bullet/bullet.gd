@tool
@icon("uid://dlxeuv6plmrs1")
class_name Bullet
extends Area2D

@export_category("Visual")
@export var texture: Texture2D

@export_category("Audio")
@export var sound: AudioStream

@export_category("Movement")
@export var angle: float = 0.0
@export var speed: Vector2
@export var acceleration: Vector2

@export_category("Damage")
@export var damage: float

@onready var visible_rect: Rect2 = get_viewport_rect().grow(100)


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _process(_delta: float) -> void:
	rotation = speed.angle() + angle - PI / 2


func _physics_process(delta: float) -> void:
	if not Engine.is_editor_hint():
		speed += acceleration * delta
		position += speed.rotated(angle - PI / 2) * delta
		
		if !visible_rect.has_point(global_position):
			queue_free()


func _draw() -> void:
	if texture:
		draw_texture(texture, -texture.get_size() / 2)


func _on_area_entered(area: Area2D) -> void:
	if area is Enemy:
		queue_free()
