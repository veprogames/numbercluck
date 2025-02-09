class_name GameSettings
extends RefCounted

var bus_music: int = AudioServer.get_bus_index(&"Music")
var bus_sounds: int = AudioServer.get_bus_index(&"Sounds")

var locale: String = TranslationServer.get_locale()

var music_volume: float = -12.0 :
	set(vol):
		music_volume = vol
		AudioServer.set_bus_volume_db(bus_music, vol)

var sound_volume: float = -6.0 :
	set(vol):
		sound_volume = vol
		AudioServer.set_bus_volume_db(bus_sounds, vol)
