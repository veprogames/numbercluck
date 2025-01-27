class_name BulletPod
extends Node2D

@export var bullet: PackedScene
@export var interval: float
@export var random_interval: float

var t: float = 0

var audio_player: AudioStreamPlayer2D


func _ready() -> void:
	if get_child_count() > 0:
		audio_player = get_children()[0] as AudioStreamPlayer2D


func _physics_process(delta: float) -> void:
	if interval > 0:
		t += 1 / interval * delta
	
	if random_interval > 0 and randf() < delta / random_interval:
		t += 1
	
	t = minf(1, t)


func shoot() -> void:
	t -= 1
	var bullet_: Bullet = create_bullet()
	if is_instance_valid(audio_player):
		audio_player.stream = bullet_.sound
		audio_player.play()
	get_tree().current_scene.add_child(bullet_)


func create_bullet() -> Bullet:
	var b: Bullet = bullet.instantiate() as Bullet
	b.global_position = global_position
	b.angle += rotation
	b.rotation = b.get_bullet_rotation()
	return b
