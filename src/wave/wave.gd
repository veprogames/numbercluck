class_name Wave
extends Node2D

signal finished

@export var title: String
@export var time_between_spawns: float
@export var music_stream: AudioStream

@onready var enemies: Node = $Enemies
@onready var spawn_timer: Timer = $SpawnTimer
@onready var title_label: Title = $CanvasLayer/Title

var spawn_points: Array[EnemySpawnPoint]
var spawn_enemies: Array[Enemy]

var finished_spawning: bool = false


func _ready() -> void:
	# show the node if it was hidden in the editor for editing purposes
	visible = true
	title_label.text = title
	
	for child: Node in get_children():
		if child is EnemySpawnPoint:
			spawn_points.append(child)
		elif child is Enemy:
			spawn_enemies.append(child)
			remove_child(child)
	
	if time_between_spawns > 0:
		spawn_timer.wait_time = time_between_spawns


func start() -> void:
	if music_stream != null:
		Audio.play_music(music_stream)
	
	title_label.start()
	
	await title_label.finished
	
	for enemy: Enemy in spawn_enemies:
		var spawn_position: Vector2 = Vector2.ZERO
		if spawn_points.size() > 0:
			@warning_ignore("unsafe_cast")
			var spawn_point: EnemySpawnPoint = spawn_points.pick_random() as EnemySpawnPoint
			spawn_position = spawn_point.position
		
		enemy.target_position = spawn_position
		spawn_enemy(enemy, spawn_position, enemy.position)
		
		if time_between_spawns > 0:
			spawn_timer.start()
			await spawn_timer.timeout
	
	finished_spawning = true
	
	if enemies.get_child_count() == 0:
		check_for_completion()


func spawn_enemy(enemy: Enemy, from_pos: Vector2, goto_pos: Vector2 = Vector2.ZERO) -> void:
	enemy.position = from_pos
	enemy.move_to_target_position(goto_pos)
	enemies.add_child(enemy)


func check_for_completion() -> void:
	if enemies.get_child_count() <= 1 and finished_spawning:
		finished.emit()


func _on_enemies_child_exiting_tree(_node: Node) -> void:
	check_for_completion()
