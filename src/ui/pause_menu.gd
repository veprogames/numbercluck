class_name PauseMenu
extends CanvasLayer

const Scene: PackedScene = preload("res://src/ui/pause_menu.tscn")
const MainMenuMusic: AudioStreamOggVorbis = preload("res://assets/music/fanfare_for_space.ogg")

@onready var tree: SceneTree = get_tree()


func _ready() -> void:
	tree.paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_button_continue_pressed() -> void:
	tree.paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	queue_free()


func _on_button_surrender_pressed() -> void:
	tree.paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	Audio.play_music(MainMenuMusic)
	tree.change_scene_to_file("res://src/mission_selection/mission_selection.tscn")


func _on_tree_exited() -> void:
	Game.settings.save_settings()


static func create() -> PauseMenu:
	return Scene.instantiate() as PauseMenu
