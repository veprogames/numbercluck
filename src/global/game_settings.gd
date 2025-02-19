class_name GameSettings
extends RefCounted

static var save_path: String = "user://settings.cfg"

var bus_music: int = AudioServer.get_bus_index(&"Music")
var bus_sounds: int = AudioServer.get_bus_index(&"Sounds")

var locale: String = TranslationServer.get_locale()

var music_volume: float = -12.0 :
	set(vol):
		music_volume = vol
		AudioServer.set_bus_volume_db(bus_music, vol)
		AudioServer.set_bus_mute(bus_music, vol <= -60)

var sound_volume: float = -6.0 :
	set(vol):
		sound_volume = vol
		AudioServer.set_bus_volume_db(bus_sounds, vol)
		AudioServer.set_bus_mute(bus_sounds, vol <= -60)


func save_settings() -> void:
	var file: ConfigFile = ConfigFile.new()
	
	file.set_value("game", "locale", locale)
	file.set_value("game", "music_volume", music_volume)
	file.set_value("game", "sound_volume", sound_volume)
	
	file.save(save_path)


func load_settings() -> void:
	var file: ConfigFile = ConfigFile.new()
	
	var err: int = file.load(GameSettings.save_path)
	
	if err != OK:
		return
	
	locale = file.get_value("game", "locale")
	music_volume = file.get_value("game", "music_volume")
	sound_volume = file.get_value("game", "sound_volume")
