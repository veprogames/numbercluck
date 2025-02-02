class_name BulletPodEnemy
extends BulletPod


func _ready() -> void:
	super._ready()
	next_shot += int(interval * 1000000.0)


func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	
	if can_shoot():
		super.shoot()
