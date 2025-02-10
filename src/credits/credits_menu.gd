class_name CreditsMenu
extends Node2D


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed(&"ui_cancel"):
		get_tree().change_scene_to_file("res://src/main_menu/main_menu.tscn")


func _on_button_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://src/main_menu/main_menu.tscn")
