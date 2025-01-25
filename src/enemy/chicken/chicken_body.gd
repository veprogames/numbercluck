@tool
@icon("uid://bjgwbtcdw0it6")
class_name ChickenBody
extends Node2D

@export var head: Texture2D = preload("res://assets/chicken/head.png")
@export var suit: Texture2D = preload("res://assets/chicken/suit.png")
@export var suit_modulate: Color = Color.WHITE
@export var body: Texture2D = preload("res://assets/chicken/body.png")
@export var leg: Texture2D = preload("res://assets/chicken/leg.png")
@export var wing: Texture2D = preload("res://assets/chicken/wing.png")

var t: float = randf() * 10


func _ready() -> void:
	queue_redraw()


func _process(delta: float) -> void:
	t += delta
	
	queue_redraw()


func _draw() -> void:
	if t == null:
		t = 0.0
	
	draw_set_transform(Vector2(-64, -32), 0.4 * sin(4 * t))
	draw_texture(wing, -wing.get_size() / 2)
	
	draw_set_transform(Vector2(64, -32), 0.4 * sin(4 * t), Vector2(-1, 1))
	draw_texture(wing, -wing.get_size() / 2)
	
	draw_set_transform(Vector2(-32, 72), 0.3 * cos(4 * t) + 0.2)
	draw_texture(leg, -leg.get_size() / 2)
	
	draw_set_transform(Vector2(32, 72), 0.3 * cos(4 * t) + 0.2, Vector2(-1, 1))
	draw_texture(leg, -leg.get_size() / 2)
	
	draw_set_transform(Vector2.ZERO, 0)
	
	draw_texture(head, -head.get_size() / 2 + Vector2.UP * 196)
	
	draw_texture(body, -body.get_size() / 2)
	draw_texture(suit, -suit.get_size() / 2, suit_modulate)
