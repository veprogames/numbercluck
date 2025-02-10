class_name LanguageButton
extends Button

var current: String :
	set(locale):
		current = locale
		if not is_node_ready():
			await ready
		TranslationServer.set_locale(locale)
		Game.settings.locale = locale
		Game.settings.save_settings()
		match locale:
			"en_US":
				text = "%s: English" % tr("Language")
			"de_DE":
				text = "%s: Deutsch" % tr("Language")
			_:
				text = "Unknown Language"


func _ready() -> void:
	current = Game.settings.locale


func _on_pressed() -> void:
	current = "de_DE" if current == "en_US" else "en_US"
