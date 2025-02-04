class_name AddFirepowerProgressOnDeath
extends Node2D

@export var target: Enemy
@export var chance_multi: float = 1.0

@onready var player_state: PlayerState = get_tree().get_first_node_in_group(&"player_state")
@onready var level: Node2D = get_tree().get_first_node_in_group(&"level")

const FirepowerScene: PackedScene = preload("res://src/collectables/firepower.tscn")


func _ready() -> void:
	target.died.connect(_on_target_died)


func get_added_amount() -> float:
	return minf(
		1.0,
		randf_range(0.005, 0.015) * 2 * chance_multi * Game.upgrades.firepower_chance.get_effect()
	)


func _on_target_died(_enemy: Enemy) -> void:
	if is_instance_valid(level) and is_instance_valid(player_state):
		player_state.firepower_progress += get_added_amount()
		
	if player_state.can_spawn_firepower():
		player_state.spawn_firepower(global_position)
