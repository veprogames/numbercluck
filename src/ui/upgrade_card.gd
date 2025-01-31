class_name UpgradeCard
extends PanelContainer

@onready var label_title: Label = $VBoxContainer/LabelTitle
@onready var button_buy: Button = $VBoxContainer/ButtonBuy

var upgrade: Upgrade :
	set(upg):
		upgrade = upg
		update_ui()
		upgrade.level_changed.connect(func(_lvl: int) -> void:
			update_ui()
		)


func update_ui() -> void:
	label_title.text = upgrade.definition.title
	button_buy.text = str(upgrade.get_price())


func _on_button_buy_pressed() -> void:
	if upgrade:
		upgrade.buy()
