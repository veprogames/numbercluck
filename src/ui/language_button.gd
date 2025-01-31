class_name LanguageButton
extends Button

var current: String :
	set(locale):
		current = locale
		if not is_node_ready():
			await ready
		TranslationServer.set_locale(locale)
		Game.save_game()
		match locale:
			"en_US":
				text = "%s: English" % tr(&"menu.language")
			"de_DE":
				text = "%s: Deutsch" % tr(&"menu.language")
			_:
				text = "Unknown Language"


func _ready() -> void:
	current = Game.settings.locale


func _on_pressed() -> void:
	current = "de_DE" if current == "en_US" else "en_US"
