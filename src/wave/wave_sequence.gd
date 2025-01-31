class_name WaveSequence
extends Node

signal finished

var waves: Array[Wave]


func _ready() -> void:
	for child: Node in get_children():
		if child is Wave:
			waves.append(child)
	
	if waves.size() <= 0:
		return
	
	for i: int in range(waves.size() - 1):
		waves[i].finished.connect(func() -> void:
			waves[i + 1].start()
		)
	
	waves[waves.size() - 1].finished.connect(func() -> void:
		finished.emit()
	)
	
	waves[0].start()
	
	finished.connect(_on_finished)


func _on_finished() -> void:
	Events.mission_completed.emit()
	var title: Title = Title.create("mission.win")
	add_child(title)
	title.start()
	await title.finished
	get_tree().change_scene_to_file("res://src/mission_selection/mission_selection.tscn")
