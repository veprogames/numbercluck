@icon("uid://8b0ra4tun5ka")
class_name Firepower
extends Area2D


func _physics_process(delta: float) -> void:
	position.y += 200 * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_entered(_area: Area2D) -> void:
	queue_free()
