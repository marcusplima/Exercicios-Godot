extends Area

func _on_Inbounds_area_exited(area):
	print('area saiu da area')
	var parent = area.get_parent()
	if area.name != 'Up' and area.name != 'Down': return

	if parent.won != false or parent.respawning != false:
		print('não perdeu')
		return

	parent.get_node('RigidBody').gravity_scale = 10
	parent.get_node('RigidBody').angular_velocity *= 2

	parent.get_node('RigidBody').axis_lock_linear_y = false
	parent.get_node('RigidBody').axis_lock_linear_x = false
	parent.get_node('RigidBody').axis_lock_linear_z = false
	
	parent.lose()

func _on_Inbounds_body_entered(body):
	print('entrou na área')
	if true: return
	
	var parent = body.get_parent()
	if body.name != 'RigidBody': return
	#print('won?: ', parent.won, ' / respawning?: ', parent.respawning)
	if parent.won != false or parent.respawning != false:
		print('não perdeu')
		return
	body.gravity_scale = 1
	
	parent.lose()
	
	body.angular_velocity *= 2



