class_name MainMenu
extends Node2D


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed(&"ui_cancel"):
		get_tree().quit()


func _on_button_missions_pressed() -> void:
	get_tree().change_scene_to_file("res://src/mission_selection/mission_selection.tscn")


func _on_button_quit_pressed() -> void:
	Game.save_game()
	get_tree().quit()


func _on_button_shop_pressed() -> void:
	get_tree().change_scene_to_file("res://src/shop_menu/shop_menu.tscn")


func _on_button_ia_pressed() -> void:
	OS.shell_open("https://www.interactionstudios.com/")


func _on_button_ia_steam_pressed() -> void:
	OS.shell_open("https://store.steampowered.com/search/?developer=InterAction%20studios")


func _on_button_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://src/credits/credits_menu.tscn")
