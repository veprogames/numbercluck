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
	
	label_firepower.text = "%d" % player.get_firepower()
	player.firepower_changed.connect(func(fp: int) -> void:
		if player.get_excessive_firepower() > 0:
			label_firepower.text = "%d+%d" % [
				player.get_effective_firepower(),
				player.get_excessive_firepower()
			]
		else:
			label_firepower.text = "%d" % fp
	)
