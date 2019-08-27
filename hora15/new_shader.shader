shader_type spatial;
render_mode cull_disabled;

void vertex(){
	VERTEX.z *= sin(TIME);
}