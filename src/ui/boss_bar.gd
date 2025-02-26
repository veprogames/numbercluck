class_name BossBar
extends ProgressBar

@onready var label: Label = $Label

var enemies: Array[Enemy] = []

var current: float = 0.0
var total: float = 0.0


func _ready() -> void:
	update_ui()


func get_total() -> float:
	var sum: float = 0.0
	for enemy: Enemy in enemies:
		if enemy.is_inside_tree():
			sum += enemy.max_hp
	return sum


func get_current() -> float:
	var sum: float = 0.0
	for enemy: Enemy in enemies:
		if enemy.is_inside_tree():
			sum += enemy.hp
	return sum


func recalculate() -> void:
	total = get_total()
	current = get_current()


func update_ui() -> void:
	visible = total > 0
	value = current / total
	label.text = F.n(current)


func add(enemy: Enemy) -> void:
	enemies.append(enemy)
	enemy.damaged.connect(_on_enemy_damaged)
	enemy.died.connect(_on_enemy_died)
	enemy.tree_entered.connect(_on_enemy_tree_entered)
	enemy.tree_exited.connect(_on_enemy_tree_exited)
	await enemy.ready
	recalculate()
	update_ui()


func _on_enemy_damaged(_enemy: Enemy) -> void:
	recalculate()
	update_ui()


func _on_enemy_died(enemy: Enemy) -> void:
	enemy.damaged.disconnect(_on_enemy_damaged)
	enemy.died.disconnect(_on_enemy_died)
	enemy.tree_entered.disconnect(_on_enemy_tree_entered)
	enemy.tree_exited.disconnect(_on_enemy_tree_exited)
	enemies.erase(enemy)
	recalculate()
	update_ui()


func _on_enemy_tree_entered() -> void:
	recalculate()
	update_ui()


func _on_enemy_tree_exited() -> void:
	recalculate()
	update_ui()
