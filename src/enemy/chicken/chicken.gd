@icon("uid://coivio5vqtpwj")
class_name Chicken
extends Enemy

var t: float = 0.0


func _process(delta: float) -> void:
	t += delta


func _on_area_entered(area: Area2D) -> void:
	var bullet: Bullet = area as Bullet
	if bullet:
		damage(bullet.damage)
