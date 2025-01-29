class_name MissionDefinition
extends Resource

@export var title: String
@export var wave_sequence: PackedScene


func get_wave_sequence() -> WaveSequence:
	return wave_sequence.instantiate() as WaveSequence
