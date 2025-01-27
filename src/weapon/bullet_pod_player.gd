class_name BulletPodPlayer
extends BulletPod

var active: bool = false


func _ready() -> void:
	super._ready()
	
	t = interval


func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	   
	if active and t >= 1:
		super.shoot()


func _unhandled_input(event: InputEvent) -> void:
	var click_event: InputEventMouseButton = event as InputEventMouseButton
	if click_event:
		active = click_event.pressed
