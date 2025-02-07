class_name MissionSelection
extends Node2D

var LevelScene: PackedScene = preload("res://src/level/level.tscn")

const MissionButtonScene: PackedScene = preload("res://src/mission_selection/mission_button.tscn")

const missions: Array[MissionDefinition] = [
	preload("res://assets/missions/mission_a_new_beginning.tres"),
	preload("res://assets/missions/mission_the_winged_threat.tres"),
]

@onready var v_box_container_missions: VBoxContainer = %VBoxContainerMissions
@onready var mission_button_test: MissionButton = $CanvasLayer/MissionButtonTest


func _ready() -> void:
	if !OS.is_debug_build():
		mission_button_test.queue_free()
	
	for definition: MissionDefinition in missions:
		var btn: MissionButton = MissionButtonScene.instantiate() as MissionButton
		btn.definition = definition
		btn.pressed.connect(func() -> void:
			select_mission(definition)
		)
		v_box_container_missions.add_child(btn)


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed(&"ui_cancel"):
		get_tree().change_scene_to_file("res://src/main_menu/main_menu.tscn")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://src/level/level.tscn")


func _on_button_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://src/main_menu/main_menu.tscn")


func select_mission(definition: MissionDefinition) -> void:
	var level: Node2D = LevelScene.instantiate() as Node2D
	var sequence: WaveSequence = definition.get_wave_sequence()
	
	var scrolling_background: TextureRect = level.get_node(^"ScrollingBackground") as TextureRect
	if scrolling_background:
		scrolling_background.texture = definition.background
	
	queue_free()
	level.add_child(sequence)
	get_tree().root.add_child(level)
	get_tree().current_scene = level


func _on_mission_button_test_mission_selected(definition: MissionDefinition) -> void:
	select_mission(definition)
