class_name BulletPod
extends Node2D

@export var bullet: PackedScene
@export var interval: float
@export var random_interval: float

var audio_player: AudioStreamPlayer2D

@onready var level: Node2D = get_tree().get_first_node_in_group(&"level")

var next_shot: int = Time.get_ticks_usec()


func _ready() -> void:
	if get_child_count() > 0:
		audio_player = get_children()[0] as AudioStreamPlayer2D


func _physics_process(delta: float) -> void:
	if random_interval > 0 and randf() < delta / random_interval:
		shoot()


func shoot(angle_offset: float = 0) -> void:
	# not optimal
	var overshot_us: int = mini(16000, Time.get_ticks_usec() - next_shot)
	next_shot = Time.get_ticks_usec() - overshot_us + int(interval * 1000000.0)
	var bullet_: Bullet = create_bullet(angle_offset)
	if is_instance_valid(audio_player):
		audio_player.stream = bullet_.sound
		audio_player.play()
	if is_instance_valid(level):
		level.add_child(bullet_)


func create_bullet(angle_offset: float = 0) -> Bullet:
	var b: Bullet = bullet.instantiate() as Bullet
	b.global_position = global_position
	b.angle += rotation + angle_offset
	b.rotation = b.get_bullet_rotation()
	return b


func can_shoot() -> bool:
	return interval > 0 and Time.get_ticks_usec() >= next_shot
