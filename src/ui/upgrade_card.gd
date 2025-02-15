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


func _ready() -> void:
	Events.saved_score_changed.connect(func(_score: float) -> void:
		update_buy_button()
	)


func update_ui() -> void:
	label_title.text = "%s Level %d" % [tr(upgrade.definition.title), upgrade.level + 1]
	label_description.text = tr(upgrade.definition.description) \
		.replace("$$effect$$", "[color=lime]%s[/color]" % upgrade.format_effect())
	update_buy_button()


func update_buy_button() -> void:
	if upgrade.is_maxed():
		button_buy.text = tr("Maxed")
		button_buy.disabled = true
	else:
		button_buy.text = F.n(upgrade.get_price())
		button_buy.disabled = !upgrade.can_afford()
	
	var cursor: CursorShape = Control.CURSOR_ARROW if button_buy.disabled else Control.CURSOR_POINTING_HAND
	button_buy.mouse_default_cursor_shape = cursor


func _on_button_buy_pressed() -> void:
	if upgrade:
		upgrade.buy()
