class_name PlayerUI
extends Panel

@export var player_state: PlayerState

@onready var h_box_container_wrapper: HBoxContainer = $HBoxContainerWrapper
@onready var label_health: Label = %LabelHealth
@onready var label_firepower: Label = %LabelFirepower
@onready var label_boosters: Label = %LabelBoosters
@onready var h_box_container_boosters: HBoxContainer = %HBoxContainerBoosters


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
	
	if Game.upgrades.booster_count.level > 0:
		label_boosters.text = "%d" % player_state.boosters
		player_state.boosters_changed.connect(func(boosts: int) -> void:
			label_boosters.text = "%d" % boosts
		)
	else:
		h_box_container_boosters.queue_free()
		h_box_container_wrapper.add_theme_constant_override(&"separation", 160)
