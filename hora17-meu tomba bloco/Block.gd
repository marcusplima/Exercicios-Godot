extends Spatial

var rotating = false

var current_position
var rotate_node = "BaseRH"
var direction
var rotate_axis

func _ready():
	current_position = 'standing'
	get_node(rotate_node).get_node("RigidBody").translate(Vector3(0,3,0))
	get_node(rotate_node).get_node("RigidBody").set_use_custom_integrator(false)
	
	#get_node(rotate_node).get_node("RigidBody").set_use_custom_integrator(true)

func _input(event):
	#para cada posição do bloco, o position3d deve ser reposicionado de acordo com o botao apertado
	if event.is_action_pressed("ui_down"):
		print('pressed down')
		match current_position:
			'standing':
				rotate_node = "BaseRH"
				direction = -1
				rotate_axis = 'z'
			'laid_right':
				pass
			'laid_left':
				pass
			'laid_back':
				pass
			'laid_front':
				pass
			"laid_upsidedown":
				pass
		get_node(rotate_node).get_node("RigidBody").set_use_custom_integrator(true)
		rotating = true

	if event.is_action_pressed('ui_up'):
		print('pressed up')
		match current_position:
			'standing':
				rotate_node = "BaseLH"
				direction = -1
				rotate_axis = 'z'
			'laid_right':
				pass
			'laid_left':
				pass
			'laid_back':
				pass
			'laid_front':
				pass
			"laid_upsidedown":
				pass
		get_node(rotate_node).get_node("RigidBody").set_use_custom_integrator(true)
		rotating = true
		
	if event.is_action_pressed('ui_left'):
		print('pressed left')
		match current_position:
			'standing':
				rotate_node = "BaseRH"
				direction = 1
				rotate_axis = 'x'
			'laid_right':
				pass
			'laid_left':
				pass
			'laid_back':
				pass
			'laid_front':
				pass
			"laid_upsidedown":
				pass
		get_node(rotate_node).get_node("RigidBody").set_use_custom_integrator(true)
		rotating = true
		
	if event.is_action_pressed('ui_right'):
		print('pressed right')
		
		
var angulo = 0

func _physics_process(delta):#process(delta):
	print($BaseRH/RigidBody.transform.origin)
	if !rotating: return
	angulo += 2
	if angulo <= 90:
		match rotate_axis:
			'z':
				get_node(rotate_node).rotate_z(deg2rad(direction * 2))
			'x':
				get_node(rotate_node).rotate_x(deg2rad(direction * 2))
			'y':
				get_node(rotate_node).rotate_y(deg2rad(direction * 2))
	else:
		rotating = false
		angulo = 0
		get_node(rotate_node).get_node("RigidBody").set_use_custom_integrator(false)
		

