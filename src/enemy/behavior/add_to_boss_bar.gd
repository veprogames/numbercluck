class_name AddToBossBar
extends Node


@export var target: Enemy


func _ready() -> void:
	var boss_bar: BossBar = get_tree().get_first_node_in_group(&"boss_bar")
	if is_instance_valid(boss_bar):
		boss_bar.add(target)
