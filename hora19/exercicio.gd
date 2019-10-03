extends Spatial

export var speed = 1.0

func _process(delta):
	$MeshInstance.translation += speed * delta * Vector3(0, 0, 1)
