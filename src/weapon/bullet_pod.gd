extends Node2D

@export var bullet: PackedScene
@export var interval: float
@export var angle: float = 0.0

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var active: bool = false
var t: float = 0


func _ready() -> void:
	t = interval - 0.01


func _physics_process(delta: float) -> void:
	if active:
		t += delta
	
	if t >= interval:
		t -= interval
		var b: Bullet = bullet.instantiate() as Bullet
		b.global_position = global_position
		b.angle += angle
		audio_stream_player_2d.stream = b.sound
		audio_stream_player_2d.play()
		get_tree().current_scene.add_child(b)


func _unhandled_input(event: InputEvent) -> void:
	var click_event: InputEventMouseButton = event as InputEventMouseButton
	if click_event:
		active = click_event.pressed
