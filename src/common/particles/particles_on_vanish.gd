class_name ParticlesOnVanish
extends GPUParticles2D

@export var target: Node2D


func _ready() -> void:
	reparent.call_deferred(get_tree().current_scene)
	
	emitting = false
	
	target.tree_exiting.connect(_on_target_tree_exiting)


func _on_target_tree_exiting() -> void:
	global_position = target.global_position
	await get_tree().physics_frame
	emitting = true
	await finished
	queue_free()
