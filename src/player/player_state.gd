class_name PlayerState
extends Node

signal player_spawned(player: Player)
signal lives_changed(lives: int)
signal firepower_changed(fp: int)
signal game_over

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

var starting_firepower: int = 0
var max_firepower: int = 5

@onready var respawn_timer: Timer = $RespawnTimer
@onready var viewport_rect: Rect2 = get_viewport().get_visible_rect()

const PlayerScene: PackedScene = preload("res://src/player/player.tscn")


func _ready() -> void:
	player = respawn_player()


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


func _on_player_damaged() -> void:
	lives -= 1
	@warning_ignore("integer_division")
	firepower = maxi(firepower / 2, firepower - 3)
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


func _on_game_over() -> void:
	var title: Title = Title.create("Mission Failed")
	add_child(title)
	title.start()
	await title.finished
	get_tree().quit()
