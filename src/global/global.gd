extends Node


func _ready() -> void:
	Game.settings.load_settings()
	
	if OS.is_debug_build():
		Game.chapters_unlocked = 999
	else:
		Game.load_game()


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed(&"window_fullscreen"):
		match DisplayServer.window_get_mode():
			DisplayServer.WINDOW_MODE_WINDOWED:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.WINDOW_MODE_FULLSCREEN:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			_:
				pass
	
	if OS.is_debug_build():
		if Input.is_action_just_pressed(&"cheat_score"):
			Game.saved_score = Game.saved_score * 2 + 100000


func _on_save_timer_timeout() -> void:
	Game.save_game()
