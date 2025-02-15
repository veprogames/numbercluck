extends Node


func _ready() -> void:
	Game.load_game()
	Game.settings.load_settings()


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed(&"window_fullscreen"):
		match DisplayServer.window_get_mode():
			DisplayServer.WINDOW_MODE_WINDOWED:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.WINDOW_MODE_FULLSCREEN:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			_:
				pass


func _on_save_timer_timeout() -> void:
	Game.save_game()
