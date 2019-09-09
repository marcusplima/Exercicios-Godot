extends Spatial

var rotating = false

var current_position
var direction
var rotate_axis
var offset
var next_position
var trans_x = 0
var trans_y = 0
var trans_z = 0
var angulo = 0
var corr = 0.5 / 90

func _ready():
	current_position = 'standing'
	get_node("RigidBody").translate(Vector3(0,3,0))

func _input(event):
	#para cada posição do bloco, o position3d deve ser reposicionado de acordo com o botao apertado
	if event.is_action_pressed("ui_down"):
		print('pressed down')
		match current_position:
			'standing':
				direction = -1
				rotate_axis = 'z'
				trans_y = 3
				next_position = 'laid_front'
				trans_x = 0
				trans_z = 0
			'laid_right':
				pass
			'laid_left':
				pass
			'laid_back':
				direction = -1
				rotate_axis = 'z'
				trans_y = -3
				next_position = 'standing'
				trans_x = 0
				trans_z = 0
			'laid_front':
				direction = -1
				rotate_axis = 'z'
				trans_y = 3.5#era 2
				next_position = 'laid_upsidedown'
				trans_x = -13.5#era 13
			"laid_upsidedown":
				direction = -1
				rotate_axis = 'z'
				trans_y = -3
				next_position = 'laid_back'
				trans_x = -13
				trans_z = 0
		rotating = true

	if event.is_action_pressed('ui_up'):
		print('pressed up')
		match current_position:
			'standing':
				direction = 1
				rotate_axis = 'z'
				trans_y = 3
				next_position = 'laid_back'
				trans_x = 0
				trans_z = 0
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
		rotating = true
		
	if event.is_action_pressed('ui_left'):
		print('pressed left')
		match current_position:
			'standing':
				direction = 1
				rotate_axis = 'x'
				trans_y = 3
				next_position = 'laid_left'
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
		rotating = true
		
	if event.is_action_pressed('ui_right'):
		print('pressed right')
		match current_position:
			'standing':
				direction = -1
				rotate_axis = 'x'
				trans_y = 3
				next_position = 'laid_right'
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
		rotating = true

func _physics_process(delta):#process(delta):
	if !rotating: return
	angulo += 2
	
	if angulo <= 90:
		match rotate_axis:
			'z':
				#rotate_z(deg2rad(direction * 2))
				rotate_object_local(Vector3(0, 0, 1), deg2rad(direction * 2))
				translate_object_local(Vector3(trans_x * corr, trans_y * corr, trans_z * corr))
			'x':
				rotate_object_local(Vector3(1, 0, 0), deg2rad(direction * 2))
				translate_object_local(Vector3(trans_x * corr, trans_y * corr, trans_z * corr))
			'y':
				pass
	else:
		rotating = false
		transform.origin = transform.origin.snapped(Vector3(0.5, 0.5, 0.5))
		angulo = 0
		current_position = next_position
		#print('current position: ', current_position)
		#print('next position: ', next_position)

