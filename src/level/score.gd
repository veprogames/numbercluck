class_name Score
extends Node

signal score_changed(new_score: float)

var score: float = 0 :
	set(s):
		score = s
		score_changed.emit(s)


func _ready() -> void:
	Events.enemy_died.connect(_on_enemy_died)
	Events.mission_completed.connect(_on_mission_completed)


func _on_enemy_died(enemy: Enemy) -> void:
	score += enemy.get_score()


func _on_mission_completed() -> void:
	Game.saved_score += score
