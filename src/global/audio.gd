class_name AudioManager
extends Node

@onready var current_music: AudioStreamPlayer = $Music


func play_music(stream: AudioStream) -> void:
	# crossfade to new music
	var new_music: AudioStreamPlayer = AudioStreamPlayer.new()
	new_music.stream = stream
	new_music.volume_db = -60
	new_music.bus = &"Music"
	
	add_child(new_music)
	new_music.play()
	
	var tween: Tween = create_tween() \
		.set_parallel()
	tween.tween_property(current_music, ^"volume_db", -60, 4.0)
	tween.tween_property(new_music, ^"volume_db", 0, 4.0) \
		.set_delay(1.0)
	
	await tween.finished
	
	current_music.queue_free()
	
	current_music = new_music
