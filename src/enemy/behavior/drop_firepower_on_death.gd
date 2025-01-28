class_name DropFirepowerOnDeath
extends Node2D

@export var target: Enemy
@export var chance_multi: float = 1.0

@onready var player_state: PlayerState = get_tree().get_first_node_in_group(&"player_state")
@onready var level: Node2D = get_tree().get_first_node_in_group(&"level")

const FirepowerScene: PackedScene = preload("res://src/collectables/firepower.tscn")


func _ready() -> void:
	target.tree_exiting.connect(_on_target_exiting_tree)


func get_drop_chance() -> float:
	var player: Player = player_state.get_player()
	if is_instance_valid(player):
		return 0.1 / (10.0 + player.get_firepower()) * chance_multi
	return 0.0


func _on_target_exiting_tree() -> void:
	if is_instance_valid(level) and randf() < get_drop_chance():
		var fp: Firepower = FirepowerScene.instantiate()
		fp.global_position = global_position
		level.add_child(fp)
