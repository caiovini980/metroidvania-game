shader_type canvas_item;

uniform vec4 hit_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 final_hit_color : source_color = vec4(1.0, 0.0, 0.0, 1.0);
uniform float hit_strength : hint_range(0.0, 1.0) = 0.0;
uniform bool is_final_hit = false;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 custom_color = texture(TEXTURE, UV);
    
    
	if (is_final_hit)
	{
		custom_color.rgb = mix(custom_color.rgb, final_hit_color.rgb, hit_strength);
	}
	else
	{
		custom_color.rgb = mix(custom_color.rgb, hit_color.rgb, hit_strength);
	}
	
	COLOR = custom_color;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
