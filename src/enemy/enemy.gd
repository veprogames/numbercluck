class_name Enemy
extends Area2D

@export var max_hp: float
@onready var hp: float = max_hp


func damage(amount: float) -> void:
	hp -= amount
	if hp <= 0:
		queue_free()
