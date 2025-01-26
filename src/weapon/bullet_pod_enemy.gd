class_name BulletPodEnemy
extends Node2D

@export var bullet: PackedScene
@export var interval: float
@export var random_interval: float
@export var angle: float = 0

var t: float = 0


func _physics_process(delta: float) -> void:
	if interval > 0:
		t += 1 / interval * delta
	
	if randf() < delta / random_interval:
		t += 1
	
	if t >= 1:
		t -= 1
		var b: Bullet = bullet.instantiate() as Bullet
		b.global_position = global_position
		b.angle += angle
		get_tree().current_scene.add_child(b)
