class_name PlayerFirepower
extends Node2D

signal firepower_changed(fp: int)

@onready var levels: Node2D = $Levels
@onready var helper_sprite: Sprite2D = $HelperSprite
var firepower_level_nodes: Array[Node] = []

var current_power: int = 0 :
	set(power):
		current_power = power
		load_firepower(power)
		firepower_changed.emit(power)


func _ready() -> void:
	helper_sprite.queue_free()
	
	for node: Node in levels.get_children():
		firepower_level_nodes.append(node)
		levels.remove_child(node)
	
	current_power = 0


func power_up() -> void:
	current_power += 1


func load_firepower(level: int) -> void:
	for node: Node in levels.get_children():
		levels.remove_child(node)
	
	var index: int = mini(level, firepower_level_nodes.size() - 1)
	levels.add_child(firepower_level_nodes[index])
