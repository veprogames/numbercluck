class_name HSliderSoundVolume
extends HSlider


func _ready() -> void:
	value = Game.settings.sound_volume


func _on_value_changed(val: float) -> void:
	Game.settings.sound_volume = val
