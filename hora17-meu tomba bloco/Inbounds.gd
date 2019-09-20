extends Area

func _on_Inbounds_body_entered(body):
	print('body entered')
	var parent = body.get_parent()
	print('won?: ', parent.won, ' / respawning?: ', parent.respawning)
	print(parent.won != false)
	if parent.won != false or parent.respawning != false:
		print('retorna')
		return
	body.gravity_scale = 1
	
	parent.lose()
	
	body.angular_velocity *= 2
