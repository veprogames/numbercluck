class_name LevelCamera
extends Camera2D

var shaking: bool = false


func shake() -> void:
	if shaking:
		return
	
	var tween: Tween = create_tween() \
		.set_ease(Tween.EASE_OUT) \
		.set_trans(Tween.TRANS_CUBIC)
	for rot: float in [10, 5, 2, 1, 0.5]:
		tween.tween_property(self, ^"rotation_degrees", rot, 0.15)
		tween.tween_property(self, ^"rotation_degrees", -rot, 0.15)
	tween.tween_property(self, ^"rotation_degrees", 0, 0.15)
	
	await tween.finished
	shaking = false


func _on_player_state_player_damaged() -> void:
	shake()
