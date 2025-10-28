shader_type canvas_item;
render_mode world_vertex_coords;

instance uniform vec2 offset = vec2(0,0);

void vertex() {
	// Called for every vertex the material is visible on.
	VERTEX += offset;//vec2(500.0*cos(TIME), 0.0);
}

vec4 sample(vec2 pos, sampler2D tex){
	vec4 col = texture(tex, pos);
	return col.rgba;//col.r*0.3 + col.b*0.3 + col.g*0.3;
}

void fragment() {
	// Called for every pixel the material is visible on.
	//COLOR.r *= (cos(TIME*10.0)+1.0)/2.0;
	float dst = 0.04;
	vec2 pos = UV;

	vec4 intensity =
		0.50 * sample(pos, TEXTURE)+
		0.125 * sample(pos+vec2(-dst,0), TEXTURE)+
		0.125 * sample(pos+vec2(0,-dst), TEXTURE)+
		0.125 * sample(pos+vec2(dst,0), TEXTURE)+
		0.125 * sample(pos+vec2(0,dst), TEXTURE);
	COLOR = intensity;//vec3(intensity, intensity, intensity);
	COLOR.rgb *= 0.8;

	//BLUR
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
