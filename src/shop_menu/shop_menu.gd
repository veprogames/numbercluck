class_name ShopMenu
extends Node2D

@onready var upgrade_card_min_firepower: UpgradeCard = %UpgradeCardMinFirepower
@onready var upgrade_card_max_firepower: UpgradeCard = %UpgradeCardMaxFirepower
@onready var label_saved_score: Label = %LabelSavedScore


func _ready() -> void:
	upgrade_card_min_firepower.upgrade = Game.upgrades.min_firepower
	upgrade_card_max_firepower.upgrade = Game.upgrades.max_firepower
	
	label_saved_score.text = "%s: %s" % [tr("Score"), F.t(Game.saved_score)]
	Events.saved_score_changed.connect(func(score: float) -> void:
		label_saved_score.text = F.t(score)
	)


func _on_button_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://src/main_menu/main_menu.tscn")
