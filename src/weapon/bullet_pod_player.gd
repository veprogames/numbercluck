class_name BulletPodPlayer
extends BulletPod


func _ready() -> void:
	super._ready()
	
	t = 1
	
	#if Input.is_action_pressed(&"player_shoot"):
	#	super.shoot()


func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	   
	if Input.is_action_pressed(&"player_shoot") and t >= 1:
		super.shoot()
