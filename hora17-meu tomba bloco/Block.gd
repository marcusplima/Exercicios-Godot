extends Spatial

var Position1 = Transform( Vector3(1, 0, 0), Vector3(0, 1, 0), Vector3(0, 0, 1), Vector3(0, 1, 0) )
var Position2 = Transform( Vector3(1, 0, 0), Vector3(0, 1, 0), Vector3(0, 0, 1), Vector3(0, 1, 0) )

var angulo = 0.0
var x_ini = 0.0
var y_ini
var x_end = 0.0
var y_end
var x_center = 0.0
var y_center = 0.0
var z_center = 0.0
var position
var rotating = false

func _ready():
	#y_ini = y_circunferencia(x_ini)
	#Position1.origin = Vector3(x_ini, y_ini, 0)
	#rotation = Vector3(0, 0, rad2deg(0))
	#transform = Position1
	position = 'standing'

func _input(event):
	if event.is_action_pressed("ui_up"):
		Position1.origin = Vector3(x_ini, y_ini, 0)
		#Position1 = Position1.rotated(Vector3(0, 0, 1), deg2rad(0))#-90.0/100.0))#angulo_ini))
		
		x_end = 1.5
		y_end = 0.5
		Position2.origin = Vector3(x_end, y_end, 0)
		#Position2 = Position2.rotated(Vector3(0, 0, 1), -0.5)#PI/2)
		transform = Position1.interpolate_with(Position2, 1.0)
		rotation_degrees = Vector3(0, 0, -90)
		
	if event.is_action_pressed("ui_down"):
		print('pressed down')
		if position == "standing":
			x_center = transform.origin.x + 0.5
			y_center = 0.0
			z_center = 0.0
			x_ini = transform.origin.x
			x_end = x_ini + 1.5
			angulo = 0.0
			rotating = true

func _physics_process(delta):
	if !rotating: return
	print('rotating')
	if abs(angulo) <= 90:
		y_ini = y_circunferencia(x_ini-x_center+0.5)
		Position1.origin = Vector3(x_ini, y_ini, 0)
		
		x_end = x_ini + 0.15
		y_end = y_circunferencia(x_end-x_center+0.5)
		Position2.origin = Vector3(x_end, y_end, 0)
		
		var v1 = Vector3(x_ini, y_ini, 0) - Vector3(x_center, y_center, z_center)
		var v2 = Vector3(x_end, y_end, 0) - Vector3(x_center, y_center, z_center)
		var cosphi = v1.dot(v2) / (v1.length() * v2.length())
		angulo -= rad2deg(acos(cosphi))
		
		print('angulo: ', angulo, ' x_ini: ', x_ini, ' y_ini: ', y_ini, ' x_end: ', x_end, ' y_end: ', y_end)
		transform = Position1.interpolate_with(Position2, 1)
		x_ini += 0.15
		rotation_degrees = Vector3(0, 0, angulo)
	else:
		rotating = false

func y_circunferencia(x):
	return sqrt(((-1) * x * x) + x + 1.0)