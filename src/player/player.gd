@icon("uid://du7f5tna07qmy")
class_name Player
extends Node2D

signal damaged
signal firepower_changed(fp: int)

@onready var visual: Node2D = $Visual
@onready var padding: Vector2 = ($Visual/Sprite2D as Sprite2D).texture.get_size() * 1.2
@onready var viewport_rect: Rect2 = get_viewport_rect()

@onready var damage_area: Area2D = $DamageArea
@onready var player_firepower: PlayerFirepower = $PlayerFirepower

var ShieldScene: PackedScene = preload("res://src/player/player_shield.tscn")

var shield: PlayerShield

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	var tween: Tween = create_tween()
	tween.tween_property(visual, ^"position:y", 0.0, 1) \
		.set_ease(Tween.EASE_OUT) \
		.set_trans(Tween.TRANS_CUBIC)
	
	add_shield()


func _unhandled_input(event: InputEvent) -> void:
	var mouse_event: InputEventMouseMotion = event as InputEventMouseMotion
	if mouse_event:
		position += mouse_event.relative
		position = position.clamp(
			viewport_rect.position + padding / 2,
			viewport_rect.end - padding / 2
		)


func _on_damage_area_area_entered(area: Area2D) -> void:
	if is_instance_valid(shield):
		return
	
	if area is Bullet or area is Enemy:
		damage()


func _on_shield_exited_tree() -> void:
	shield.tree_exited.disconnect(_on_shield_exited_tree)
	if damage_area.get_overlapping_areas().size() > 0:
		damage()


func damage() -> void:
	damaged.emit()


func add_shield() -> void:
	var player_shield: PlayerShield = ShieldScene.instantiate() as PlayerShield
	player_firepower.current_power = maxi(0, player_firepower.current_power - 3)
	visual.add_child(player_shield)
	shield = player_shield
	shield.tree_exited.connect(_on_shield_exited_tree)


func get_firepower() -> int:
	return player_firepower.current_power


func get_effective_firepower() -> int:
	return player_firepower.get_effective_firepower()


func get_excessive_firepower() -> int:
	return get_firepower() - get_effective_firepower()


func _on_collection_area_area_entered(area: Area2D) -> void:
	if area is Firepower:
		player_firepower.power_up()


func _on_player_firepower_firepower_changed(fp: int) -> void:
	firepower_changed.emit(fp)
