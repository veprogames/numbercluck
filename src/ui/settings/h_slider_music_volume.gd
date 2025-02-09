class_name HSliderMusicVolume
extends HSlider


func _ready() -> void:
	value = Game.settings.music_volume


func _on_value_changed(val: float) -> void:
	Game.settings.music_volume = val
