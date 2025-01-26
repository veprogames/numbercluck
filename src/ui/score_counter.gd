class_name ScoreCounter
extends TextureRect

@onready var label: Label = $Label

@export var score: Score


func _ready() -> void:
	score.score_changed.connect(_on_score_changed)


func _on_score_changed(new_score: float) -> void:
	label.text = "%.0f" % new_score
