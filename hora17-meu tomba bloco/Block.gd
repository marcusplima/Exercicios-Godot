extends Spatial
#Variáveis para interpolação de posição
var Position1 = Transform( Vector3(1, 0, 0), Vector3(0, 1, 0), Vector3(0, 0, 1), Vector3(0, 1, 0) )
var Position2 = Transform( Vector3(1, 0, 0), Vector3(0, 1, 0), Vector3(0, 0, 1), Vector3(0, 1, 0) )

var angulo = 0.0 #angulo de rotação do bloco
var x_ini = 0.0 #posição inicial
var y_ini
var z_ini
var x_end = 0.0 #posição final
var y_end
var z_end
var x_center = 0.0 #posição do centro
var y_center = 0.0
var z_center = 0.0
var x_center_offset#distância entre o centro e a posição inicial
var y_center_offset
var z_center_offset
var position #como o bloco está? Em pé ou deitado
var next_position #Qual é a próxima posição do bloco
var rotating = false #Se o bloco está rotacionando
var rot_x #Se o bloco vai rotacionar em torno do eixo x
var rot_z #Se o bloco vai rotacionar em torno do eixo z
var direction_axis #1 ou -1, inverte o sentido de translação
var direction_angle #1 ou -1, inverte o sentido de rotação
var rotation_ini
var step
var r_x
var r_z
var r_y


func _ready():
	position = 'standing' #posição inicial

func _input(event):
	if event.is_action_pressed("ui_up"):
		print('pressed up')
		if position == "standing":
			step = 0.15
			x_center_offset = -0.5 #distância do eixo de rotação até o centro de massa
			y_center_offset = -1
			z_center_offset = 0
			x_center = transform.origin.x + x_center_offset #posição do eixo de rotação
			y_center = transform.origin.y + y_center_offset
			z_center = transform.origin.z + z_center_offset
			print('centro x: ', x_center, ' y: ', y_center,' z: ', z_center)
			x_ini = transform.origin.x#Posições iniciais e finais
			x_end = x_ini - 1.5
			z_ini = transform.origin.z
			z_end = transform.origin.z
			angulo = 0.0 #zerar o angulo de rotação
			rotation_ini = 0
			direction_angle = 1 #Gira antihorário em z
			direction_axis = -1 #Translação para y negativo
			next_position = 'laying_x' #próxima posição deitado paralelamente ao eixo x
			rot_x = 0 #rotacionar em Z
			rot_z = 1
			r_x = 0
			r_z = 0
			r_y = 0
			rotating = true #Pode iniciar rotação
		if position == "laying_x":
			step = 0.15
			x_center_offset = -1.0
			y_center_offset = -0.5
			z_center_offset = 0.0
			x_center = transform.origin.x + x_center_offset
			y_center = transform.origin.y + y_center_offset
			z_center = transform.origin.z + z_center_offset
			print('centro x: ', x_center, ' y: ', y_center,' z: ', z_center)
			x_ini = transform.origin.x
			x_end = x_ini - 1.5
			z_ini = transform.origin.z
			z_end = transform.origin.z
			angulo = 0.0
			rotation_ini = -90
			direction_angle = 1
			direction_axis = -1
			next_position = 'standing'
			rot_x = 0
			rot_z = 1
			r_x = 0
			r_y = 0
			r_z = 0
			rotating = true
		if position == "laying_z":
			step = 0.1
			x_center_offset = -0.5
			y_center_offset = -0.5
			z_center_offset = 0.0
			x_center = transform.origin.x + x_center_offset
			y_center = transform.origin.y + y_center_offset
			z_center = transform.origin.z + z_center_offset
			print('centro x: ', x_center, ' y: ', y_center,' z: ', z_center)
			x_ini = transform.origin.x
			x_end = x_ini + 1.0
			z_ini = transform.origin.z
			z_end = transform.origin.z
			angulo = 0.0
			rotation_ini = -90
			direction_angle = 1.0
			direction_axis = -1.0
			next_position = 'laying_z'
			rot_x = 1
			rot_z = 0
			r_x = -90
			r_y = -90
			r_z = 90
			rotating = true

	if event.is_action_pressed("ui_down"):
		print('pressed down**********************')
		if position == "standing":
			step = 0.15
			x_center_offset = 0.5
			y_center_offset = -1.0
			z_center_offset = 0.0
			x_center = transform.origin.x + x_center_offset
			y_center = transform.origin.y + y_center_offset
			z_center = transform.origin.z + z_center_offset
			print('centro x: ', x_center, ' y: ', y_center,' z: ', z_center)
			x_ini = transform.origin.x
			x_end = x_ini + 1.5
			z_ini = transform.origin.z
			z_end = transform.origin.z
			angulo = 0.0
			rotation_ini = 0
			direction_angle = -1
			direction_axis = 1
			next_position = 'laying_x'
			rot_x = 0
			rot_z = 1
			r_x = 0
			r_y = 0
			r_z = 0
			rotating = true
		if position == "laying_x":
			step = 0.15
			x_center_offset = 1.0
			y_center_offset = -0.5
			z_center_offset = 0.0
			x_center = transform.origin.x + x_center_offset
			y_center = transform.origin.y + y_center_offset
			z_center = transform.origin.z + z_center_offset
			print('centro x: ', x_center, ' y: ', y_center,' z: ', z_center)
			x_ini = transform.origin.x
			x_end = x_ini + 1.5
			z_ini = transform.origin.z
			z_end = transform.origin.z
			angulo = 0.0
			rotation_ini = -90
			direction_angle = -1
			direction_axis = 1
			next_position = 'standing'
			rot_x = 0
			rot_z = 1
			r_x = 0
			r_y = 0
			r_z = 0
			rotating = true
		if position == "laying_z":
			#posição inicial -90, -90, 90
			#posição final -180, -90, 90
			step = 0.1
			x_center_offset = 0.5
			y_center_offset = -0.5
			z_center_offset = 0.0
			x_center = transform.origin.x + x_center_offset
			y_center = transform.origin.y + y_center_offset
			z_center = transform.origin.z + z_center_offset
			print('centro x: ', x_center, ' y: ', y_center,' z: ', z_center)
			x_ini = transform.origin.x
			x_end = x_ini + 1.0
			z_ini = transform.origin.z
			z_end = transform.origin.z
			angulo = 0.0
			rotation_ini = -90
			direction_angle = -1.0
			direction_axis = 1.0
			next_position = 'laying_z'
			rot_x = 1
			rot_z = 0
			r_x = -90
			r_y = -90
			r_z = 90
			rotating = true

	if event.is_action_pressed("ui_left"):
		print('pressed left***********************')
		if position == "standing":
			step = 0.15
			x_center_offset = 0.0
			y_center_offset = -1
			z_center_offset = 0.5
			x_center = transform.origin.x + x_center_offset
			y_center = transform.origin.y + y_center_offset
			z_center = transform.origin.z + z_center_offset
			print('centro x: ', x_center, ' y: ', y_center,' z: ', z_center)
			x_ini = transform.origin.x
			x_end = x_ini
			z_ini = transform.origin.z
			z_end = transform.origin.z + 1.5
			angulo = 0.0
			rotation_ini = 0
			direction_angle = 1
			direction_axis = 1
			next_position = 'laying_z'
			rot_x = 1
			rot_z = 0
			r_y = 0
			rotating = true
		if position == "laying_z":
			step = 0.15
			x_center_offset = 0.0
			y_center_offset = -0.5
			z_center_offset = 1.0
			x_center = transform.origin.x + x_center_offset
			y_center = transform.origin.y + y_center_offset
			z_center = transform.origin.z + z_center_offset
			print('centro x: ', x_center, ' y: ', y_center,' z: ', z_center)
			x_ini = transform.origin.x
			x_end = x_ini 
			z_ini = transform.origin.z
			z_end = transform.origin.z + 1.5
			angulo = 0.0
			rotation_ini = 90
			direction_angle = 1
			direction_axis = 1
			next_position = 'standing'
			rot_x = 1
			rot_z = 0
			r_y = 0
			rotating = true
		if position == "laying_x":
			#0,0 -90
			#90,0,-90
			step = 0.1
			x_center_offset = 0
			y_center_offset = -0.5
			z_center_offset = 0.5
			x_center = transform.origin.x + x_center_offset
			y_center = transform.origin.y + y_center_offset
			z_center = transform.origin.z + z_center_offset
			print('centro x: ', x_center, ' y: ', y_center,' z: ', z_center)
			x_ini = transform.origin.x
			x_end = transform.origin.x
			z_ini = transform.origin.z
			z_end = transform.origin.z + + 1.0
			angulo = 0.0
			rotation_ini = 0
			direction_angle = 1.0
			direction_axis = 1.0
			next_position = 'laying_x'
			rot_x = 0
			rot_z = 1
			r_x = 0
			r_y = 0
			r_z = -90
			rotating = true

	if event.is_action_pressed("ui_right"):
		print('pressed right')
		if position == "standing":
			step = 0.15
			x_center_offset = 0.0
			y_center_offset = -1
			z_center_offset = -0.5
			x_center = transform.origin.x + x_center_offset
			y_center = transform.origin.y + y_center_offset
			z_center = transform.origin.z + z_center_offset
			print('centro x: ', x_center, ' y: ', y_center,' z: ', z_center)
			x_ini = transform.origin.x
			x_end = x_ini
			z_ini = transform.origin.z
			z_end = transform.origin.z - 1.5
			angulo = 0.0
			rotation_ini = 0
			direction_angle = -1
			direction_axis = -1
			next_position = 'laying_z'
			rot_x = 1
			rot_z = 0
			r_y = 0
			rotating = true
		if position == "laying_z":
			step = 0.15
			x_center_offset = 0.0
			y_center_offset = -0.5
			z_center_offset = -1.0
			x_center = transform.origin.x + x_center_offset
			y_center = transform.origin.y + y_center_offset
			z_center = transform.origin.z + z_center_offset
			print('centro x: ', x_center, ' y: ', y_center,' z: ', z_center)
			x_ini = transform.origin.x
			x_end = x_ini 
			z_ini = transform.origin.z
			z_end = transform.origin.z - 1.5
			angulo = 0.0
			rotation_ini = 90
			direction_angle = -1
			direction_axis = -1
			next_position = 'standing'
			rot_x = 1
			rot_z = 0
			r_y = 0
			rotating = true
var teste = 0

func _physics_process(delta):
	teste +=1
	#if teste <5: return
	teste = 0
	if !rotating: return #Se nenhuma função solicitou rotação, sair
	if abs(angulo) <= 89: #Não finalizou a rotação, faça
		if rot_z: #Calcula posição inicial baseada no eixo de rotação
			if position == next_position:
				y_ini = y_ctr(z_ini - z_center + z_center_offset)
				z_end = z_ini + ( direction_axis * step)
			else:
				y_ini = y_ctr(x_ini - x_center + x_center_offset)
				x_end = x_ini + ( direction_axis * step)
		if rot_x:
			if position == next_position:
				y_ini = y_ctr(x_ini - x_center + x_center_offset)
				x_end = x_ini + ( direction_axis * step)
			else:
				y_ini = y_ctr(z_ini - z_center + z_center_offset)
				z_end = z_ini + ( direction_axis * step)
		
		Position1.origin = Vector3(x_ini, y_ini, z_ini)# Grava posição inicial
		
		if rot_z: #Calcula a posição final baseada do eixo de rotação
			if position == next_position:
				y_end = y_ctr(z_end - z_center + z_center_offset)
			else:
				y_end = y_ctr(x_end - x_center + x_center_offset)
				
		if rot_x:
			if position == next_position:
				y_end = y_ctr(x_end - x_center + x_center_offset)
			else:
				y_end = y_ctr(z_end - z_center + z_center_offset)
			
		Position2.origin = Vector3(x_end, y_end, z_end) #Grava a posição final

		#calcula os vetores entre centro e as duas posições
		var v1 = Vector3(x_ini, y_ini, z_ini) - Vector3(x_center, y_center, z_center)
		var v2 = Vector3(x_end, y_end, z_end) - Vector3(x_center, y_center, z_center)
		# Calcula cosseno do angulo usando fórmula do produto escalar
		var cosphi = v1.dot(v2) / (v1.length() * v2.length()) 
		#Incrementa ângulo se rotação
		angulo = angulo + (direction_angle * rad2deg(acos(cosphi)))
		
		#ajustar aqui para possibilitar rotação em y também.
		if position == next_position:
			match position:
				"laying_z":
					print('z')
					#r_x = rotation_degrees.x
					r_x = rot_x * (angulo + rotation_ini)
				"laying_x":
					print('x')
					#r_z = rotation_degrees.z
					r_z = rot_z * (angulo + rotation_ini)
		else:
			r_x = rot_x * (angulo + rotation_ini)
			r_z = rot_z * (angulo + rotation_ini)
		
		print('angulo: ', angulo, ' x_ini: ', x_ini, ' y_ini: ', y_ini, ' x_end: ', x_end, ' y_end: ', y_end)
		print('rotation_degrees: ', rotation_degrees)
		transform = Position1.interpolate_with(Position2, 1) # Translada o objeto
		
		if rot_z:#rotaciona o objeto, baseado no eixo selecionado
			print('rot_z')
			if position == next_position:
				z_ini = z_ini + (direction_axis * step)
			else:
				x_ini = x_ini + (direction_axis * step)
		if rot_x:
			print('rot_x')
			if position == next_position:
				x_ini = x_ini + (direction_axis * step)
			else:
				z_ini = z_ini + (direction_axis * step) 

		rotation_degrees = Vector3(r_x, r_y, r_z)#Rotaciona o objeto
		print('rotation_degrees: ', rotation_degrees)
	else: #Já finalizou a rotação, faça.
		rotating = false #Não rodar mais
		position = next_position #Armazenar posição do fim
		$RigidBody.custom_integrator = false

func y_ctr(x):
	#Usar para deitar o bloco
	#função de cálculo da altura baseada na equação da circunferência de giro
	#do centro de gravidade em torno da aresta x² + y² = r²
	x = abs(x)
	match position:
		"laying_x":
			match next_position:
				'standing':
					return sqrt(((-1.0) * x * x) + (2.0 * x) + 0.25)
				"laying_x":
					return sqrt(((-1.0) * x * x) + (1.0 * x) + 0.25)
		"laying_z":
				match next_position:
					'standing':
						return sqrt(((-1.0) * x * x) + (2.0 * x) + 0.25)
					"laying_z":
						return sqrt(((-1.0) * x * x) + (1.0 * x) + 0.25)
		"standing":
			return sqrt(((-1.0) * x * x) + (1.0 * x) + 1.0)
