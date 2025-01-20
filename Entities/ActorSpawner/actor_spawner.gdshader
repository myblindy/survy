shader_type canvas_item;

uniform vec4 highlight_color : source_color;
uniform float lifetime_percentage : hint_range(0.0, 1.0, 0.01);

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	color *= highlight_color;
	
	float time_delay_scale = mix(3.0, 1.0, lifetime_percentage);
	float time = clamp(fract(TIME / time_delay_scale) * time_delay_scale, 0.0, 0.5);
	color.a *= 1.0 - (sin(time * 10.0) + 1.0) / 2.0;
	
	COLOR = color;
}