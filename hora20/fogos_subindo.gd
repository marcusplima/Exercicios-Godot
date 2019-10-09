extends Particles2D

var desaceleracao = 5 #Desacelera a subida
var y_ini #Posição y inicial
var explodiu = false #Se explodiu
var mov_x = 0 #Incremento do movimentação em x

signal explodir

func _ready():
	#Armazena valores iniciais
	y_ini = position.y
	mov_x = rand_range(-5,5)

func _process(delta):
	if explodiu: return #Não mover se já explodiu
	desaceleracao += delta * delta #Aumenta a desaceleração com o tempo
	position.y -= (delta * 1300) - desaceleracao #Reposiciona y
	position.x += mov_x #Reposiciona X
	if abs(position.y-y_ini) > rand_range(350,500): #emite explisão em altura aleatória
		emit_signal("explodir")
		explodiu = true

func _on_Timer_timeout():
	#Termina a cena de subida depois de 1 segundo
	queue_free()
