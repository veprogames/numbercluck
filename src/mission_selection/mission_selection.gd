class_name MissionSelection
extends Node2D

var LevelScene: PackedScene = preload("res://src/level/level.tscn")

const MissionButtonScene: PackedScene = preload("res://src/mission_selection/mission_button.tscn")

const missions: Array[MissionDefinition] = [
	preload("res://assets/missions/mission_a_new_beginning.tres"),
	preload("res://assets/missions/mission_the_winged_threat.tres"),
]

@onready var v_box_container_missions: VBoxContainer = %VBoxContainerMissions


func _ready() -> void:
	for definition: MissionDefinition in missions:
		var btn: MissionButton = MissionButtonScene.instantiate() as MissionButton
		btn.definition = definition
		btn.pressed.connect(func() -> void:
			select_mission(definition)
		)
		v_box_container_missions.add_child(btn)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://src/level/level.tscn")


func _on_button_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://src/main_menu/main_menu.tscn")


func select_mission(definition: MissionDefinition) -> void:
	var level: Node2D = LevelScene.instantiate() as Node2D
	var sequence: WaveSequence = definition.get_wave_sequence()
	
	queue_free()
	level.add_child(sequence)
	get_tree().root.add_child(level)
	get_tree().current_scene = level
