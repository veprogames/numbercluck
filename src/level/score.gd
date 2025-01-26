class_name Score
extends Node

signal score_changed(new_score: float)

var score: float = 0 :
	set(s):
		score = s
		score_changed.emit(s)


func _ready() -> void:
	Events.enemy_died.connect(_on_enemy_died)


func _on_enemy_died(enemy: Enemy) -> void:
	score += enemy.get_score()
