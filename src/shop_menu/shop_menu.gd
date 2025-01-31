class_name ShopMenu
extends Node2D

@onready var upgrade_card_min_firepower: UpgradeCard = %UpgradeCardMinFirepower
@onready var upgrade_card_max_firepower: UpgradeCard = %UpgradeCardMaxFirepower


func _ready() -> void:
	upgrade_card_min_firepower.upgrade = Game.upgrades.min_firepower
	upgrade_card_max_firepower.upgrade = Game.upgrades.max_firepower


func _on_button_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://src/main_menu/main_menu.tscn")
