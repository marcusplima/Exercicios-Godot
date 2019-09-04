extends Area

func _on_Inbounds_area_exited( area ):
	var body = area.get_parent()
	var parent = body.get_parent()
	print('area path', area.get_path())
	print('body path: ', body.get_path())
	#Verificar porque a área Ending é chamada quando o jogador alcança o fim.
	#verificar porque dá pau quando cai de lado ou em pé na área externa.
	#a queda só está funcionando quando cai tombando.
	#if area.get_path() != "/root/Spatial/Level/Ending":
	if parent.won or parent.respawning: return
	body.gravity_scale = 1
	parent.lose()
	body.angular_velocity *= 2
