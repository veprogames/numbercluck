class_name Game
extends Node

static var saved_score: float = 0.0 :
	set(score):
		saved_score = score
		Events.saved_score_changed.emit(score)

static var chapters_unlocked: int = 1

static var upgrades: ContentUpgrades = ContentUpgrades.new()

static var settings: GameSettings = GameSettings.new()

static var SAVE_PATH: String = "user://game.save"

static func save_game() -> void:
	var data: Dictionary = {
		"saved_score": saved_score,
		"chapters_unlocked": chapters_unlocked,
		"upgrades": {
			"min_firepower": upgrades.min_firepower.level,
			"max_firepower": upgrades.max_firepower.level,
			"firepower_chance": upgrades.firepower_chance.level,
			"booster_count": upgrades.booster_count.level,
			"max_lives": upgrades.max_lives.level,
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
	if "chapters_unlocked" in data:
		Game.chapters_unlocked = data.chapters_unlocked
	if "min_firepower" in data.upgrades:
		Game.upgrades.min_firepower.level = data.upgrades.min_firepower
	if "max_firepower" in data.upgrades:
		Game.upgrades.max_firepower.level = data.upgrades.max_firepower
	if "firepower_chance" in data.upgrades:
		Game.upgrades.firepower_chance.level = data.upgrades.firepower_chance
	if "booster_count" in data.upgrades:
		Game.upgrades.booster_count.level = data.upgrades.booster_count
	if "max_lives" in data.upgrades:
		Game.upgrades.max_lives.level = data.upgrades.max_lives
