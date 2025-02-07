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


func is_maxed() -> bool:
	return level >= definition.max_level and definition.max_level != -1


func can_afford() -> bool:
	return Game.saved_score >= get_price()


func buy() -> bool:
	var price: float = get_price()
	
	if is_maxed():
		return false
	
	if !can_afford():
		return false
	
	Game.saved_score -= price
	level += 1
	bought.emit()
	return true


func format_effect() -> String:
	return definition.effect_display_options.format(get_effect())
