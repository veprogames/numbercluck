class_name MissionDefinition
extends Resource

@export var title: String
@export var wave_sequence: PackedScene
@export var chapter: int = 0
@export var background: Texture = preload("res://assets/backgrounds/blue_nebula.png")


func get_wave_sequence() -> WaveSequence:
	return wave_sequence.instantiate() as WaveSequence


func is_unlocked() -> bool:
	return Game.chapters_unlocked >= chapter
