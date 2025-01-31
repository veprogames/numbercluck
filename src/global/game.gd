class_name Game
extends Node

static var saved_score: float = 0.0
static var upgrades: ContentUpgrades = ContentUpgrades.new()

static var settings: GameSettings = GameSettings.new()

static var SAVE_PATH: String = "user://game.save"

static func save_game() -> void:
	var data: Dictionary = {
		"saved_score": saved_score,
		"upgrades": {
			"min_firepower": upgrades.min_firepower.level,
			"max_firepower": upgrades.max_firepower.level,
		},
		"settings": {
			"locale": settings.locale
		}
	}
	
	var file: FileAccess = FileAccess.open_compressed(
		SAVE_PATH,
		FileAccess.WRITE,
		FileAccess.COMPRESSION_ZSTD
	)
	if file:
		file.store_var(data)
		file.close()

static func load_game() -> void:
	var file: FileAccess = FileAccess.open_compressed(
		SAVE_PATH,
		FileAccess.READ,
		FileAccess.COMPRESSION_ZSTD
	)
	
	if not file:
		return
	
	var data: Dictionary = file.get_var()
	
	file.close()
	
	Game.saved_score = data.saved_score
	Game.upgrades.min_firepower.level = data.upgrades.min_firepower
	Game.upgrades.max_firepower.level = data.upgrades.max_firepower
	Game.settings.locale = data.settings.locale
