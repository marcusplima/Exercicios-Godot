extends Node2D
#Variável para carregar cena de explosão
var explosion_scene = preload("res://fogos.tscn")

#Variável para carregar cena de subida
var rising_scene = preload("res://fogos_subindo.tscn")

func _input(event):
	#ao clique do botão esquerdo do mouse
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		#Criar instância da cena de subida
		var rising_instance=rising_scene.instance()
		#Liga a emissão de partículas
		rising_instance.emitting = true
		#Inicia a cena na posição do clique
		rising_instance.position = get_global_mouse_position()
		#Conecta o sinal de explodir com mostrar a cena de explosão
		rising_instance.connect("explodir",self,"explodir_antes",[rising_instance.get_node("Area2D")])
		#Adiciona o novo nó na árvore
		var stage_node=get_parent()
		stage_node.add_child(rising_instance)

func explodir_antes(area):
	#Armazena nó que explodiu
	var subindo = area.get_parent()
	#Apaga o losango branco
	subindo.get_node('Sprite').visible = false
	#Desliga a emissão de fumaça
	subindo.emitting = false
	#Criar instância da cena de explosão
	var explosion_instance=explosion_scene.instance()
	#Liga a emissão de partículas
	explosion_instance.emitting = true
	#Coloca a explosão no local da partícula que sobe
	explosion_instance.position = area.global_position
	#Adiciona o novo nó na árvore
	var stage_node=get_parent()
	stage_node.add_child(explosion_instance)

