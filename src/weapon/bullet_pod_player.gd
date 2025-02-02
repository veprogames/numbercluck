class_name BulletPodPlayer
extends BulletPod

@export var pitch_scale: float = 1.0
@export var volume_linear: float = 1.0


func _ready() -> void:
	super._ready()
	
	if is_instance_valid(audio_player):
		audio_player.pitch_scale = pitch_scale
		audio_player.volume_db = linear_to_db(volume_linear)


func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	   
	if can_shoot() and Input.is_action_pressed(&"player_shoot"):
		super.shoot()
