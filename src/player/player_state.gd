class_name PlayerState
extends Node

enum PlayerStates {
	NORMAL,
	BOOSTED,
	DEAD,
	INVINCIBLE,
	GAME_OVER,
}

# emitted on state changes
signal player_spawned
signal player_damaged
signal boost_started
signal boost_ended
signal game_over

signal lives_changed(lives: int)
signal firepower_changed(fp: int)
signal boosters_changed(boosts: int)

@onready var boost_timer: Timer = $BoostTimer
@onready var respawn_timer: Timer = $RespawnTimer
@onready var game_over_timer: Timer = $GameOverTimer
@onready var viewport_rect: Rect2 = get_viewport().get_visible_rect()
@onready var level: Node2D = get_tree().get_first_node_in_group(&"level")
@onready var audio_stream_player_game_over: AudioStreamPlayer = $AudioStreamPlayerGameOver

var player: Player

var state: PlayerStates = PlayerStates.DEAD

var lives: int = int(Game.upgrades.max_lives.get_effect()) :
	set(l):
		lives = l
		lives_changed.emit(l)

var firepower: int = 0 :
	set(fp):
		firepower = fp
		if is_instance_valid(player):
			player.player_firepower.current_power = mini(fp, max_firepower)
		firepower_changed.emit(fp)

var boosters: int = int(Game.upgrades.booster_count.get_effect()) :
	set(b):
		boosters = b
		boosters_changed.emit(b)

var min_firepower: int = int(Game.upgrades.min_firepower.get_effect())
var max_firepower: int = int(Game.upgrades.max_firepower.get_effect())

var firepower_progress: float = randf()

const PlayerScene: PackedScene = preload("res://src/player/player.tscn")
const FirepowerScene: PackedScene = preload("res://src/collectables/firepower.tscn")
const MainMenuMusic: AudioStreamOggVorbis = preload("res://assets/music/fanfare_for_space.ogg")


func _ready() -> void:
	set_state(PlayerStates.NORMAL)
	firepower = min_firepower
	Events.mission_completed.connect(func() -> void:
		Game.save_game()
		set_state(PlayerStates.INVINCIBLE)
	)


func _unhandled_input(event: InputEvent) -> void:
	var drag_event: InputEventScreenDrag = event as InputEventScreenDrag
	var boosted: bool = drag_event and drag_event.index == 2
	
	if Input.is_action_just_pressed(&"ui_cancel"):
		owner.add_child(PauseMenu.create())
	if Input.is_action_just_released(&"player_boost") or boosted:
		if boosters > 0 and state != PlayerStates.BOOSTED:
			boosters -= 1
			set_state(PlayerStates.BOOSTED)
	
	if OS.is_debug_build():
		if Input.is_action_just_pressed(&"cheat_lives"):
			lives += 1
		if Input.is_action_just_pressed(&"cheat_firepower"):
			spawn_firepower(Vector2(randf() * viewport_rect.size.x, -100))
		if Input.is_action_just_pressed(&"cheat_boosters"):
			boosters += 1


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		owner.add_child(PauseMenu.create())


func get_player() -> Player:
	if is_instance_valid(player):
		return player
	return null


func is_dead() -> bool:
	return lives <= 0


func is_boosted() -> bool:
	return state == PlayerStates.BOOSTED


func get_effective_firepower() -> int:
	return mini(firepower, max_firepower)


func get_excessive_firepower() -> int:
	return firepower - get_effective_firepower()


func get_normalized_firepower() -> int:
	return firepower - min_firepower


func respawn_player() -> Player:
	var player_: Player = PlayerScene.instantiate()
	player_.position = viewport_rect.position + viewport_rect.size * Vector2(0.5, 0.9)
	player_.damaged.connect(_on_player_player_damaged)
	player_.firepower_collected.connect(_on_player_firepower_collected)
	add_child(player_)
	player_.player_firepower.current_power = get_effective_firepower()
	return player_


func add_firepower_progress(progress: float) -> void:
	firepower_progress += progress


func can_spawn_firepower() -> bool:
	return firepower_progress >= 1.0


func spawn_firepower(position: Vector2) -> void:
	firepower_progress = maxf(0.0, firepower_progress - 1.0)
	var fp: Firepower = FirepowerScene.instantiate()
	fp.global_position = position
	level.add_child.call_deferred(fp)


func set_state(new_state: PlayerStates) -> void:
	match [state, new_state]:
		[PlayerStates.INVINCIBLE, PlayerStates.DEAD]:
			return
		[var s, PlayerStates.DEAD] when s != PlayerStates.DEAD:
			player_damaged.emit()
		
		[PlayerStates.INVINCIBLE, PlayerStates.GAME_OVER]:
			return
		[var s, PlayerStates.GAME_OVER] when s != PlayerStates.GAME_OVER:
			game_over.emit()
		
		[var s, PlayerStates.NORMAL] when s == PlayerStates.DEAD:
			player_spawned.emit()
		
		[PlayerStates.BOOSTED, var s] when s != PlayerStates.BOOSTED:
			boost_ended.emit()
		[PlayerStates.NORMAL, PlayerStates.BOOSTED], \
		[PlayerStates.INVINCIBLE, PlayerStates.BOOSTED]:
			boost_started.emit()
	
	state = new_state


func _on_player_firepower_collected() -> void:
	firepower += 1


func _on_player_player_damaged() -> void:
	set_state(PlayerStates.DEAD)


func _on_game_over() -> void:
	Audio.fade_out_music()
	game_over_timer.start()
	await game_over_timer.timeout
	
	audio_stream_player_game_over.play()
	
	var title: Title = Title.create("Game Over!")
	add_child(title)
	title.start()
	await title.finished
	
	game_over_timer.start()
	await game_over_timer.timeout
	Audio.play_music(MainMenuMusic)
	
	get_tree().change_scene_to_file("res://src/mission_selection/mission_selection.tscn")


func _on_tree_exited() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_player_spawned() -> void:
	player = respawn_player()


func _on_player_damaged() -> void:
	lives -= 1
	
	var target_fp: int = min_firepower + int(get_normalized_firepower() / 1.5) - 1
	firepower = maxi(target_fp, min_firepower)
	
	player.damaged.disconnect(_on_player_player_damaged)
	player.firepower_collected.disconnect(_on_player_firepower_collected)
	player.queue_free()
	
	if is_dead():
		set_state(PlayerStates.GAME_OVER)
	else:
		respawn_timer.start()
		await respawn_timer.timeout
		set_state(PlayerStates.NORMAL)


func _on_boost_started() -> void:
	boost_timer.start()
	await boost_timer.timeout
	set_state(PlayerStates.NORMAL)
