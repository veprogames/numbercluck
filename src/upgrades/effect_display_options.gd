class_name EffectDisplayOptions
extends Resource

@export var places: int
@export var prefix: String
@export var suffix: String


func format(effect: float) -> String:
	return "%s%s%s" % [prefix, F.n(effect, places), suffix]
