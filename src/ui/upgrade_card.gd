class_name UpgradeCard
extends PanelContainer

@onready var label_title: Label = %LabelTitle
@onready var button_buy: Button = %ButtonBuy
@onready var label_description: RichTextLabel = %LabelDescription

var upgrade: Upgrade :
	set(upg):
		upgrade = upg
		update_ui()
		upgrade.level_changed.connect(func(_lvl: int) -> void:
			update_ui()
		)


func update_ui() -> void:
	label_title.text = upgrade.definition.title
	label_description.text = tr(upgrade.definition.description) \
		.replace("$$effect$$", "[color=lime]%s[/color]" % upgrade.format_effect())
	button_buy.text = F.n(upgrade.get_price())


func _on_button_buy_pressed() -> void:
	if upgrade:
		upgrade.buy()
