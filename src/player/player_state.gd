class_name PlayerState
extends Node

signal player_spawned(player: Player)
signal lives_changed(lives: int)
signal game_over

var player: Player

var lives: int = 3 :
	set(l):
		lives = l
		lives_changed.emit(l)

@onready var respawn_timer: Timer = $RespawnTimer

const PlayerScene: PackedScene = preload("res://src/player/player.tscn")


func _ready() -> void:
	player = respawn_player()


func get_player() -> Player:
	if is_instance_valid(player):
		return player
	return null


func is_dead() -> bool:
	return lives <= 0


func _on_player_damaged() -> void:
	lives -= 1
	player.damaged.disconnect(_on_player_damaged)
	player.queue_free()
	if is_dead():
		game_over.emit()
	else:
		respawn_timer.start()
		await respawn_timer.timeout
		player = respawn_player()


func respawn_player() -> Player:
	var player_: Player = PlayerScene.instantiate()
	player_.position = Vector2(800, 700)
	player_.damaged.connect(_on_player_damaged)
	add_child(player_)
	player_spawned.emit(player_)
	return player_


func _on_game_over() -> void:
	var title: Title = Title.create("Mission Failed")
	add_child(title)
	title.start()
	await title.finished
	get_tree().quit()
