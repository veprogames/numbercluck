class_name BulletPodPlayer
extends BulletPod

@export var pitch_scale: float = 1.0
@export var volume_linear: float = 1.0

@onready var player_state: PlayerState = get_tree().get_first_node_in_group(&"player_state")

var base_interval: float
var boost_interval: float

var base_pitch: float
var boost_pitch: float

var random_spread: bool = false


func _ready() -> void:
	super._ready()
	
	base_interval = interval
	boost_interval = interval / 3.0
	
	base_pitch = pitch_scale
	boost_pitch = pitch_scale * 3
	
	if is_instance_valid(player_state):
		player_state.boost_started.connect(_on_player_state_boost_started)
		player_state.boost_ended.connect(_on_player_state_boost_ended)
		
		if player_state.is_boosted():
			activate_boost()
	
	if is_instance_valid(audio_player):
		audio_player.pitch_scale = pitch_scale
		audio_player.volume_db = linear_to_db(volume_linear)


func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	   
	if can_shoot() and Input.is_action_pressed(&"player_shoot"):
		var offset: float = randf_range(-1, 1) * PI / 4 if random_spread else 0.0
		super.shoot(offset)


func activate_boost() -> void:
	interval = boost_interval
	audio_player.pitch_scale = boost_pitch
	random_spread = true
	next_shot = Time.get_ticks_usec()
	


func _on_player_state_boost_started() -> void:
	activate_boost()


func _on_player_state_boost_ended() -> void:
	interval = base_interval
	audio_player.pitch_scale = base_pitch
	random_spread = false
