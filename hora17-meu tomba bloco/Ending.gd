extends Area

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Ending_body_entered(body):
	print('ending')
	var parent = body.get_parent()
	print(parent.next_position)
	if parent.next_position == "standing":
		parent.won = true
		$GravityTimer.connect("timeout", self, "_on_GravityTimer_timeout", [parent, body])
		$GravityTimer.wait_time = 1.0
		$GravityTimer.one_shot = true
		$GravityTimer.start()


func _on_GravityTimer_timeout(block, body):
	block.win()
	body.gravity_scale = 1
	$GravityTimer.disconnect("timeout", self, "_on_GravityTimer_timeout")
