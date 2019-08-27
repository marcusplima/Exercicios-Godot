shader_type spatial;

void vertex(){
	VERTEX.z *= sin(TIME);
}