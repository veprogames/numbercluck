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


func _on_finished() -> void:
	get_tree().quit()
