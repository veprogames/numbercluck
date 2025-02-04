@tool
class_name EnemySpawnTarget
extends Node2D

@export var enemy: PackedScene


func _ready() -> void:
	var parent: Node = get_parent()
	if parent:
		var e: Enemy = enemy.instantiate() as Enemy
		e.global_position = global_position
		e.name += "_%d" % (randi() % 10000)
		print("Adding ", e ," to ", parent)
		parent.add_child.call_deferred(e)
		e.set_deferred(&"owner", owner)
		queue_free.call_deferred()
