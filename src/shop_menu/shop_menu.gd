class_name ShopMenu
extends Node2D

@onready var upgrade_card: UpgradeCard = $CanvasLayer/UpgradeCard


func _ready() -> void:
	upgrade_card.upgrade = Game.upgrades.min_firepower


func _on_button_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://src/main_menu/main_menu.tscn")
