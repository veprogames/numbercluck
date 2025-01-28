class_name PlayerUI
extends Panel

@export var player_state: PlayerState

@onready var label_health: Label = %LabelHealth
@onready var label_firepower: Label = %LabelFirepower


func _ready() -> void:
	player_state.player_spawned.connect(_on_player_state_player_respawned)
	
	label_health.text = "%d" % player_state.lives
	player_state.lives_changed.connect(func(lives_: int) -> void:
		label_health.text = "%d" % lives_
	)

func _on_player_state_player_respawned(player: Player) -> void:
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
