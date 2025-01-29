class_name MissionButton
extends Button

signal mission_selected(definition: MissionDefinition)

@export var definition: MissionDefinition


func _ready() -> void:
	text = definition.title


func _on_pressed() -> void:
	mission_selected.emit(definition)
