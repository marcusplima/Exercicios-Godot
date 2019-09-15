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


func _ready():
	position = 'standing' #posição inicial

func _input(event):
	if event.is_action_pressed("ui_up"):
		print('pressed up')
		if position == "standing":
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
			direction_angle = 1 #Gira antihorário em z
			direction_axis = -1 #Translação para y negativo
			next_position = 'laying_x' #próxima posição deitado paralelamente ao eixo x
			rot_x = 0 #rotacionar em Z
			rot_z = 1
			rotating = true #Pode iniciar rotação

	if event.is_action_pressed("ui_down"):
		print('pressed down')
		if position == "standing":
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
			direction_angle = -1
			direction_axis = 1
			next_position = 'laying_x'
			rot_x = 0
			rot_z = 1
			rotating = true

	if event.is_action_pressed("ui_left"):
		print('pressed left')
		if position == "standing":
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
			direction_angle = 1
			direction_axis = 1
			next_position = 'laying_z'
			rot_x = 1
			rot_z = 0
			rotating = true

	if event.is_action_pressed("ui_right"):
		print('pressed right')
		if position == "standing":
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
			direction_angle = -1
			direction_axis = -1
			next_position = 'laying_z'
			rot_x = 1
			rot_z = 0
			rotating = true

func _physics_process(delta):
	if !rotating: return #Se nenhuma função solicitou rotação, sair
	print('rotating')
	if abs(angulo) <= 89: #Não finalizou a rotação, faça
		if rot_z: #Calcula posição inicial baseada no eixo de rotação
			y_ini = y_laying(x_ini - x_center + x_center_offset)
			x_end = x_ini + ( direction_axis * 0.15)
		if rot_x:
			y_ini = y_laying(z_ini - z_center + z_center_offset)
			z_end = z_ini + ( direction_axis * 0.15)
			
		Position1.origin = Vector3(x_ini, y_ini, z_ini)# Grava posição inicial
		
		if rot_z: #Calcula a posição final baseada do eixo de rotação
			y_end = y_laying(x_end - x_center + x_center_offset)
		if rot_x:
			y_end = y_laying(z_end - z_center + z_center_offset)
			
		Position2.origin = Vector3(x_end, y_end, z_end) #Grava a posição final
		
		print('z_ini: ', z_ini)
		print('z_end: ', z_end)
		print('z_center: ', z_center)
		#calcula os vetores entre centro e as duas posições
		var v1 = Vector3(x_ini, y_ini, z_ini) - Vector3(x_center, y_center, z_center)
		var v2 = Vector3(x_end, y_end, z_end) - Vector3(x_center, y_center, z_center)
		# Calcula cosseno do angulo usando fórmula do produto escalar
		var cosphi = v1.dot(v2) / (v1.length() * v2.length()) 
		#Incrementa ângulo se rotação
		angulo = angulo + (direction_angle * rad2deg(acos(cosphi)))
		
		print('angulo: ', angulo, ' x_ini: ', x_ini, ' y_ini: ', y_ini, ' x_end: ', x_end, ' y_end: ', y_end)
		transform = Position1.interpolate_with(Position2, 1) # Translada o objeto
		if rot_z:#rotaciona o objeto, baseado no eixo selecionado
			x_ini = x_ini + (direction_axis * 0.15)
		if rot_x:
			z_ini = z_ini + (direction_axis * 0.15)
			
		rotation_degrees = Vector3(rot_x * angulo, 0, rot_z * angulo)#Rotaciona o objeto
	else: #Já finalizou a rotação, faça.
		rotating = false #Não rodar mais
		position = next_position #Armazenar posição do fim

func y_laying(x):
	#Usar para deitar o bloco
	#função de cálculo da altura baseada na equação da circunferência de giro
	#do centro de gravidade em torno da aresta x² + y² = r²
	x = abs(x)
	return sqrt(((-1) * x * x) + x + 1.0)
	
func y_standing(x):
	#Usar para levantar o bloco
	#função de cálculo da altura baseada na equação da circunferência de giro
	#do centro de gravidade em torno da aresta x² + y² = r²
	x = abs(x)
	return sqrt(((-1) * x * x) + (2 * x) + 0.5)