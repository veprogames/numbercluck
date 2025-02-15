@icon("uid://8b0ra4tun5ka")
class_name Firepower
extends Area2D

@onready var audio_stream_player_collect: AudioStreamPlayer2D = $AudioStreamPlayerCollect
@onready var effect_container: Node = get_tree().get_first_node_in_group(&"effect_container")


func _physics_process(delta: float) -> void:
	position.y += 200 * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_entered(_area: Area2D) -> void:
	if effect_container:
		audio_stream_player_collect.reparent(effect_container)
		audio_stream_player_collect.play()
	queue_free()
