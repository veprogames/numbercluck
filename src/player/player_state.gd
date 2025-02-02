class_name PlayerState
extends Node

signal player_spawned(player: Player)
signal player_damaged
signal lives_changed(lives: int)
signal firepower_changed(fp: int)
signal game_over

@onready var respawn_timer: Timer = $RespawnTimer
@onready var viewport_rect: Rect2 = get_viewport().get_visible_rect()
@onready var level: Node2D = get_tree().get_first_node_in_group(&"level")

var player: Player

var lives: int = 3 :
	set(l):
		lives = l
		lives_changed.emit(l)

var firepower: int = 0 :
	set(fp):
		firepower = fp
		if is_instance_valid(player):
			player.player_firepower.current_power = fp
		firepower_changed.emit(fp)

var min_firepower: int = int(Game.upgrades.min_firepower.get_effect())
var max_firepower: int = int(Game.upgrades.max_firepower.get_effect())

var firepower_progress: float = randf()

var mission_completed: bool = false

const PlayerScene: PackedScene = preload("res://src/player/player.tscn")
const FirepowerScene: PackedScene = preload("res://src/collectables/firepower.tscn")


func _ready() -> void:
	player = respawn_player()
	firepower = min_firepower
	Events.mission_completed.connect(func() -> void:
		mission_completed = true
	)


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed(&"ui_cancel"):
		get_tree().change_scene_to_file("res://src/main_menu/main_menu.tscn")


func get_player() -> Player:
	if is_instance_valid(player):
		return player
	return null


func is_dead() -> bool:
	return lives <= 0


func get_effective_firepower() -> int:
	return mini(firepower, max_firepower)


func get_excessive_firepower() -> int:
	return firepower - get_effective_firepower()


func get_normalized_firepower() -> int:
	return firepower - min_firepower


func _on_player_damaged() -> void:
	if mission_completed:
		return
	
	lives -= 1
	player_damaged.emit()
	#@warning_ignore("integer_division")
	var target_fp: int = min_firepower + int(get_normalized_firepower() / 1.5)
	firepower = maxi(target_fp, min_firepower)
	player.damaged.disconnect(_on_player_damaged)
	player.firepower_collected.disconnect(_on_player_firepower_collected)
	player.queue_free()
	if is_dead():
		game_over.emit()
	else:
		respawn_timer.start()
		await respawn_timer.timeout
		player = respawn_player()


func _on_player_firepower_collected() -> void:
	if firepower < max_firepower:
		firepower += 1


func respawn_player() -> Player:
	var player_: Player = PlayerScene.instantiate()
	player_.position = viewport_rect.position + viewport_rect.size * Vector2(0.5, 0.9)
	player_.damaged.connect(_on_player_damaged)
	player_.firepower_collected.connect(_on_player_firepower_collected)
	add_child(player_)
	player_.player_firepower.current_power = get_effective_firepower()
	player_spawned.emit(player_)
	return player_


func add_firepower_progress(progress: float) -> void:
	firepower_progress += progress


func can_spawn_firepower() -> bool:
	return firepower_progress >= 1.0


func spawn_firepower(position: Vector2) -> void:
	firepower_progress -= 1.0
	var fp: Firepower = FirepowerScene.instantiate()
	fp.global_position = position
	level.add_child(fp)


func _on_game_over() -> void:
	var title: Title = Title.create("Game Over!")
	add_child(title)
	title.start()
	await title.finished
	get_tree().change_scene_to_file("res://src/mission_selection/mission_selection.tscn")


func _on_tree_exited() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
