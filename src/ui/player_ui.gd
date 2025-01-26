class_name PlayerUI
extends Panel

@export var player: Player

@onready var label_health: Label = %LabelHealth
@onready var label_firepower: Label = %LabelFirepower


func _ready() -> void:
	label_health.text = "%d" % player.lives
	player.lives_changed.connect(func(lives_: int) -> void:
		label_health.text = "%d" % lives_
	)
