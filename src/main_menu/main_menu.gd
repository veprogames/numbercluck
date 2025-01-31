class_name MainMenu
extends Node2D


func _ready() -> void:
	Game.saved_score = 1e8


func _on_button_missions_pressed() -> void:
	get_tree().change_scene_to_file("res://src/mission_selection/mission_selection.tscn")


func _on_button_quit_pressed() -> void:
	get_tree().quit()


func _on_button_shop_pressed() -> void:
	get_tree().change_scene_to_file("res://src/shop_menu/shop_menu.tscn")


func _on_button_ia_pressed() -> void:
	OS.shell_open("https://www.interactionstudios.com/")


func _on_button_ia_steam_pressed() -> void:
	OS.shell_open("https://store.steampowered.com/search/?developer=InterAction%20studios")
