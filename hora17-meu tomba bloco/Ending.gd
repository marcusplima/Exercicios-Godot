extends Area

func _on_Ending_body_entered(body):
	print('ending')
	var parent = body.get_parent()
	if body.name != 'RigidBody': return
	if parent.next_position == "standing" and parent.won == false:
		parent.won = true
		$GravityTimer.connect("timeout", self, "_on_GravityTimer_timeout", [parent, body])
		$GravityTimer.wait_time = 1.0
		$GravityTimer.one_shot = true
		$GravityTimer.start()


func _on_GravityTimer_timeout(block, body):
	print('gravity timer')
	block.win()
	body.gravity_scale = 1
	body.axis_lock_linear_y = false
	body.axis_lock_linear_x = false
	body.axis_lock_linear_z = false
	$GravityTimer.disconnect("timeout", self, "_on_GravityTimer_timeout")
