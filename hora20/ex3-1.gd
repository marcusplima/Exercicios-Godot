extends Spatial

func _input(event):
	$Particles.translation = Vector3((event.position.x * -30 / 1023) + 15, (event.position.y * -18 / 599) + 8, 0)

