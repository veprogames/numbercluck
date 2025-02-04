class_name ParticlesOnVanish
extends GPUParticles2D

@export var target: Node2D

@onready var tree: SceneTree = get_tree()


func _ready() -> void:
	var effect_container: Node = get_tree().get_first_node_in_group(&"effect_container")
	if is_instance_valid(effect_container):
		owner = null
		reparent.call_deferred(effect_container)
	
	emitting = false
	
	target.tree_exiting.connect(_on_target_tree_exiting)


func _on_target_tree_exiting() -> void:
	if not is_inside_tree():
		return
	global_position = target.global_position
	if is_instance_valid(tree):
		await tree.physics_frame
	_start_emitting.call_deferred()


func _start_emitting() -> void:
	emitting = true
	await finished
	queue_free()
