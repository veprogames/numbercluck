class_name Upgrade
extends RefCounted

signal bought
signal level_changed(lvl: int)

var definition: UpgradeDefinition
var level: int = 0 :
	set(l):
		level = l
		level_changed.emit(l)


func _init(definition_: UpgradeDefinition) -> void:
	definition = definition_


func get_price() -> float:
	return definition.price_formula.get_value(level)


func get_effect() -> float:
	return definition.effect_formula.get_value(level)


func buy() -> bool:
	var price: float = get_price()
	
	if definition.max_level != -1 and level >= definition.max_level:
		return false
	
	if Game.saved_score < price:
		return false
	
	Game.saved_score -= price
	level += 1
	bought.emit()
	return true
