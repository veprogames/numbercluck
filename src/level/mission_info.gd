class_name MissionInfo
extends Node

@export var mission_definition: MissionDefinition


func _ready() -> void:
	Events.mission_completed.connect(func() -> void:
		Game.chapters_unlocked = maxi(Game.chapters_unlocked, get_chapter() + 1)
	)


func get_chapter() -> int:
	return mission_definition.chapter
