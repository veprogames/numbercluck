class_name AudioOnVanish
extends AudioStreamPlayer2D

@export var target: Node2D


func _ready() -> void:
	reparent.call_deferred(Audio)
	
	target.tree_exited.connect(_on_target_exited_tree)


func _on_target_exited_tree() -> void:
	play()
	await finished
	queue_free()
