class_name ScoreCounter
extends Panel

@onready var label: Label = $MarginContainer/Label

@export var score: Score

var target_score: float = 0
var current_score: float = 0

var constant_speed: float = 0

func _ready() -> void:
	score.score_changed.connect(_on_score_changed)


func _process(delta: float) -> void:
	current_score = lerpf(current_score, target_score, 3 * delta)
	current_score = move_toward(current_score, target_score, constant_speed * 0.1 * delta)
	
	label.text = F.n(current_score)


func _on_score_changed(new_score: float) -> void:
	constant_speed = absf(new_score - target_score)
	target_score = new_score
