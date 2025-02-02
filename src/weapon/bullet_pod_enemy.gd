class_name BulletPodEnemy
extends BulletPod


func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	
	if can_shoot():
		super.shoot()
