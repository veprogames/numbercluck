class_name Enemy
extends Area2D

@export var max_hp: float
@onready var hp: float = max_hp

@onready var target_position: Vector2 = position
var position_offset: Vector2 = Vector2.ZERO
var target_offset: Vector2 = Vector2.ZERO

@onready var viewport_rect: Rect2 = get_viewport_rect().grow(-32)

func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _physics_process(delta: float) -> void:
	target_offset = target_offset.lerp(Vector2.ZERO, 5 * delta)
	position_offset = position_offset.lerp(target_offset, 10 * delta)
	
	target_position = target_position.clamp(viewport_rect.position, viewport_rect.end)
	
	position = target_position + position_offset


func damage(amount: float) -> void:
	hp -= amount
	if hp <= 0:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	var bullet: Bullet = area as Bullet
	if bullet:
		damage(bullet.damage)
		target_offset += (global_position - bullet.global_position).normalized() * 16
