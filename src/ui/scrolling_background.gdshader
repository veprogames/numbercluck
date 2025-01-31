shader_type canvas_item;

void fragment() {
	float y = mod(UV.y - TIME / 60.0, 1.0);
	COLOR = texture(TEXTURE, vec2(UV.x, y));
}