@tool
class_name EnemyMoveByPath
extends Node2D

@export var target: Enemy
@export var curve: Curve2D
@export var speed: float
@export var loop: bool

var current_position: float = 0.0

var length: float


func _ready() -> void:
	length = curve.get_baked_length()
	curve.changed.connect(queue_redraw)
	queue_redraw()


func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	
	if target.moving_to_target:
		return
	
	target.additional_offsets[self] = curve.sample_baked(current_position)
	current_position += speed * delta
	if loop:
		current_position = fmod(current_position, length)
	else:
		current_position = clampf(current_position, 0, length)


func _draw() -> void:
	if !Engine.is_editor_hint():
		return
	
	if !curve:
		return
	
	var points: PackedVector2Array = curve.get_baked_points()
	for i: int in range(len(points) - 1):
		var a: Vector2 = points[i]
		var b: Vector2 = points[i + 1]
		if i % 2 == 0:
			draw_line(a, b, Color.ORANGE * 0.6, 2)
