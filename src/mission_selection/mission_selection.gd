class_name MissionSelection
extends Node2D

var LevelScene: PackedScene = preload("res://src/level/level.tscn")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://src/level/level.tscn")


func _on_button_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://src/main_menu/main_menu.tscn")


func _on_mission_button_mission_selected(definition: MissionDefinition) -> void:
	var level: Node2D = LevelScene.instantiate() as Node2D
	var sequence: WaveSequence = definition.get_wave_sequence()
	
	queue_free()
	level.add_child(sequence)
	get_tree().root.add_child(level)
	get_tree().current_scene = level
