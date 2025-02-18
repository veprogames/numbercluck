class_name AudioOnVanish
extends AudioStreamPlayer2D

@export var target: Node2D


func _ready() -> void:
	var effect_container: Node = get_tree().get_first_node_in_group(&"effect_container")
	if is_instance_valid(effect_container):
		owner = null
		reparent.call_deferred(effect_container)
	
	target.tree_exiting.connect(_on_target_exiting_tree)


func _on_target_exiting_tree() -> void:
	if not is_inside_tree():
		return
	global_position = target.global_position
	play()
	await finished
	queue_free()
