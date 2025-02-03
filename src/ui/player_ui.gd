class_name PlayerUI
extends Panel

@export var player_state: PlayerState

@onready var label_health: Label = %LabelHealth
@onready var label_firepower: Label = %LabelFirepower
@onready var label_boosters: Label = %LabelBoosters


func _ready() -> void:
	label_health.text = "%d" % player_state.lives
	player_state.lives_changed.connect(func(lives_: int) -> void:
		label_health.text = "%d" % lives_
	)
	
	label_firepower.text = "%d" % player_state.firepower
	player_state.firepower_changed.connect(func(fp: int) -> void:
		if player_state.get_excessive_firepower() > 0:
			label_firepower.text = "%d+%d" % [
				player_state.get_effective_firepower(),
				player_state.get_excessive_firepower()
			]
		else:
			label_firepower.text = "%d" % fp
	)
	
	label_boosters.text = "%d" % player_state.boosters
	player_state.boosters_changed.connect(func(boosts: int) -> void:
		label_boosters.text = "%d" % boosts
	)
