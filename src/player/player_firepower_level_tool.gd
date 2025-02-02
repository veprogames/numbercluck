@tool
extends Node2D

func _ready() -> void:
	visibility_changed.connect(refresh)

func refresh() -> void:
	if visible and Engine.is_editor_hint():
		var calc_dps: float = 0.0
		var index: int = get_parent().get_children().find(self)
		for child: Node in get_children():
			var pod: BulletPodPlayer = child as BulletPodPlayer
			if pod:
				var bullet: Bullet = pod.bullet.instantiate() as Bullet
				calc_dps += bullet.damage / pod.interval
				bullet.queue_free()
		var desired: float = get_desired_dps(index)
		print("[%d] %s DPS, %s Desired" % [index, str(calc_dps), str(desired)])


func get_desired_dps(index: int) -> float:
	return 200 + 200 * index + 30 * 1.25 ** index
