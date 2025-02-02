class_name BulletPod
extends Node2D

@export var bullet: PackedScene
@export var interval: float
@export var random_interval: float

var audio_player: AudioStreamPlayer2D

@onready var level: Node2D = get_tree().get_first_node_in_group(&"level")

var next_shot: int = Time.get_ticks_usec()


func _ready() -> void:
	next_shot += int(interval * 1000000.0)
	
	if get_child_count() > 0:
		audio_player = get_children()[0] as AudioStreamPlayer2D


func _physics_process(delta: float) -> void:
	if random_interval > 0 and randf() < delta / random_interval:
		shoot()


func shoot() -> void:
	next_shot += int(interval * 1000000.0)
	var bullet_: Bullet = create_bullet()
	if is_instance_valid(audio_player):
		audio_player.stream = bullet_.sound
		audio_player.play()
	if is_instance_valid(level):
		level.add_child(bullet_)


func create_bullet() -> Bullet:
	var b: Bullet = bullet.instantiate() as Bullet
	b.global_position = global_position
	b.angle += rotation
	b.rotation = b.get_bullet_rotation()
	return b


func can_shoot() -> bool:
	return interval > 0 and Time.get_ticks_usec() >= next_shot
