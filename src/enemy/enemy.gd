class_name Enemy
extends Area2D

signal damaged(enemy: Enemy)
signal died(enemy: Enemy)

@export var score: float
@export var max_hp: float
@onready var hp: float = max_hp

var velocity: Vector2 = Vector2.ZERO
@onready var target_position: Vector2 = position

var additional_offsets: Dictionary = {}

var current_offset: Vector2 = Vector2.ZERO
var target_offset: Vector2 = Vector2.ZERO

var moving_to_target: bool = false
var moving_to_target_pos: Vector2 = Vector2.ZERO
@export var moving_to_target_speed: float = 3.0


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _physics_process(delta: float) -> void:
	if moving_to_target:
		target_position = target_position.lerp(
			moving_to_target_pos,
			moving_to_target_speed * delta
		)
		target_position = target_position.move_toward(
			moving_to_target_pos,
			moving_to_target_speed * 16 * delta
		)
		if (moving_to_target_pos - target_position).length_squared() < 1:
			moving_to_target = false
	else:
		target_position += velocity * delta
	
	target_offset = target_offset.lerp(Vector2.ZERO, 5 * delta)
	current_offset = current_offset.lerp(target_offset, 10 * delta)
	
	position = target_position + current_offset
	
	for value: Variant in additional_offsets.values():
		if value is Vector2:
			position += value
	
	velocity = Vector2.ZERO


func damage(amount: float) -> void:
	if hp <= 0:
		return
	
	damaged.emit(self)
	hp -= amount
	if hp <= 0:
		died.emit(self)
		Events.enemy_died.emit(self)
		queue_free()


func move_to_target_position(target: Vector2) -> void:
	moving_to_target = true
	moving_to_target_pos = target


func _on_area_entered(area: Area2D) -> void:
	var bullet: Bullet = area as Bullet
	if bullet:
		damage(bullet.damage)
		target_offset += (global_position - bullet.global_position).normalized() * 16
