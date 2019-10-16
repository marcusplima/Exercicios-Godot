extends Particles
var desaceleracao = 0.000001 #Desacelera a subida
var y_ini #Posição y inicial
var explodiu = false #Se explodiu
var mov_x = 0 #Incremento do movimentação em x

signal explodir

func _ready():
	#Armazena valores iniciais
	y_ini = translation.y
	mov_x = rand_range(-0.05, 0.05)

func _process(delta):
	if explodiu: return #Não mover se já explodiu
	#desaceleracao += delta * delta #Aumenta a desaceleração com o tempo
	desaceleracao = 0
	#translation.y += delta
	translation.y += (delta * 1) - desaceleracao #Reposiciona y
	translation.x += mov_x #Reposiciona X
	print()
	if abs(translation.y-y_ini) > rand_range(2,3): #emite explisão em altura aleatória
		emit_signal("explodir")
		explodiu = true


func _on_Timer_timeout():
	queue_free()
