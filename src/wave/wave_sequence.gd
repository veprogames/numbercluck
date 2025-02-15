class_name WaveSequence
extends Node

signal finished

var audio_stream_player_win: AudioStreamPlayer
var win_timer: Timer

var waves: Array[Wave]

const WinSound: AudioStreamOggVorbis = preload("res://assets/player/mission_complete.ogg")
const MainMusic: AudioStreamOggVorbis = preload("res://assets/music/fanfare_for_space.ogg")


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
	
	audio_stream_player_win = AudioStreamPlayer.new()
	audio_stream_player_win.stream = WinSound
	add_child(audio_stream_player_win)
	
	win_timer = Timer.new()
	win_timer.wait_time = 3
	add_child(win_timer)


func _on_finished() -> void:
	Events.mission_completed.emit()
	Audio.fade_out_music()
	
	win_timer.start()
	await win_timer.timeout
	
	audio_stream_player_win.play()
	
	var title: Title = Title.create(tr("Mission Complete!"))
	add_child(title)
	title.start()
	await title.finished
	
	win_timer.start()
	await win_timer.timeout
	
	Audio.play_music(MainMusic)
	get_tree().change_scene_to_file("res://src/mission_selection/mission_selection.tscn")
