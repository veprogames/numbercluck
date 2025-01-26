class_name Title
extends Label

signal finished


func _ready() -> void:
	visible_ratio = 0.0


func start() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(self, ^"visible_ratio", 1.0, 1.0) \
		.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, ^"visible_ratio", 0.0, 1.0) \
		.set_ease(Tween.EASE_IN_OUT) \
		.set_delay(1)
	await tween.finished
	finished.emit()
	queue_free()
