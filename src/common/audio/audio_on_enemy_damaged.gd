class_name AudioOnEnemyDamaged
extends AudioStreamPlayer2D

@export var target: Enemy


func _ready() -> void:
	target.damaged.connect(_on_enemy_damaged)


func _on_enemy_damaged(_enemy: Enemy) -> void:
	play()
