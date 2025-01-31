class_name GameBackground
extends ParallaxBackground

@onready var parallax_layer: ParallaxLayer = $ParallaxLayer

func _ready() -> void:
	parallax_layer.motion_offset.y = get_yscroll()
	

func _process(_delta: float) -> void:
	parallax_layer.motion_offset.y = get_yscroll()


func get_yscroll() -> float:
	return Time.get_ticks_msec() * 0.05
