class_name MissionButton
extends Button

signal mission_selected(definition: MissionDefinition)

@export var definition: MissionDefinition


func _ready() -> void:
	text = definition.title if is_unlocked() else "???"
	disabled = !is_unlocked()


func is_unlocked() -> bool:
	return definition.chapter <= Game.chapters_unlocked


func _on_pressed() -> void:
	if is_unlocked():
		mission_selected.emit(definition)
