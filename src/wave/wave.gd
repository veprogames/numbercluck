class_name Wave
extends Node

signal finished

@export var title: String
@export var time_between_spawns: float

@onready var enemies: Node = $Enemies
@onready var spawn_timer: Timer = $SpawnTimer

var spawn_points: Array
var spawn_targets: Array


func _ready() -> void:
	spawn_points = get_children().filter(func(node: Node) -> bool:
		return node is EnemySpawnPoint
	)
	
	spawn_targets = get_children().filter(func(node: Node) -> bool:
		return node is EnemySpawnTarget
	)
	
	if time_between_spawns > 0:
		spawn_timer.wait_time = time_between_spawns


func start() -> void:
	for target: EnemySpawnTarget in spawn_targets:
		var spawn_position: Vector2 = Vector2.ZERO
		if spawn_points.size() > 0:
			@warning_ignore("unsafe_cast") # can't type array properly when using Array.filter
			var spawn_point: EnemySpawnPoint = spawn_points.pick_random() as EnemySpawnPoint
			spawn_position = spawn_point.position
		
		spawn(target.enemy, spawn_position, target.position)
		
		if time_between_spawns > 0:
			spawn_timer.start()
			await spawn_timer.timeout


func spawn(scene: PackedScene, from_pos: Vector2, goto_pos: Vector2 = Vector2.ZERO) -> void:
	var enemy: Enemy = scene.instantiate() as Enemy
	enemy.position = from_pos
	enemy.move_to_target_position(goto_pos)
	enemies.add_child(enemy)


func _on_enemies_child_exiting_tree(_node: Node) -> void:
	if enemies.get_child_count() <= 1:
		finished.emit()
