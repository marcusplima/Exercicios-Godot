extends Area

const BlockClass = preload("res://block.gd")

enum Direction { UP, DOWN, RIGHT, LEFT }
enum Orientation { PARALLEL, ORTHOGONAL }
enum RestPosition { STANDING, LYING }

var won = true
var respawning = true

func _on_Ending_body_entered( body ):
	var block = body.get_parent()
	if block.rest_position == RestPosition.STANDING:
		block.won = true
		$GravityTimer.connect("timeout", self, "_on_GravityTimer_timeout", [ block, body ])
		$GravityTimer.wait_time = block.movement_duration
		$GravityTimer.one_shot = true
		$GravityTimer.start()

func _on_GravityTimer_timeout(block, body):
	block.win()
	body.gravity_scale = 1
	$GravityTimer.disconnect("timeout", self, "_on_GravityTimer_timeout")
