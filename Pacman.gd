extends AnimatedSprite

onready var tiles = get_parent().get_node("Board/TileMap")

var posdisc
var dir
var destdisc
var destcont
var speed

############################MAIN##############
func _ready():
	spawn()
	set_process(true)
############################FIM DA MAIN#######
	
#############INICIO RESPAW####################
func spawn() :
	posdisc = Vector2(10, 16)
	set_position(posdisc * 32 + Vector2(16, 16))
	
	dir = Vector2(0, 0)
	destdisc = posdisc
	destcont = get_position()
	
	speed = 150
#############FIM RESPAW##################################
###################MOVIMENTACAODIRECAO###################
func _process(delta):
	var delcont = destcont - get_position()
	if delcont != Vector2(0, 0):
		if delcont.length() < 2:
			set_position(destdisc * 32 + Vector2(16, 16))
			posdisc = destdisc
			
			
			if tiles.get_cell(posdisc.x, posdisc.y) == 1: #verifica  pontuacao
				tiles.set_cell(posdisc.x, posdisc.y, -1) #se tiver elimina celula
			if tiles.get_cell(posdisc.x, posdisc.y) == 2: #verifica pontuacao grande
				tiles.set_cell(posdisc.x, posdisc.y, -1) #se tiver elimina celula
		else:
			set_position(get_position() + delta * speed * delcont.normalized())
	else:
		if dir != Vector2(0, 0):
			var destdiscaux = posdisc + dir
			if destdiscaux == Vector2(21, 10):#passar de um lado do mapa para o outro
				destdiscaux = Vector2(0, 10)
				set_position(Vector2(-1, 10) * 32 + Vector2(16, 16)) 
			elif destdiscaux == Vector2(-1, 10):
				destdiscaux = Vector2(20, 10)
				set_position(Vector2(21, 10) * 32 + Vector2(16, 16))
			if tiles.get_cell(destdiscaux.x, destdiscaux.y) != 0 and destdiscaux != Vector2(10, 9):  #colisao com as paredes/areaghosts
				destdisc = destdiscaux
				destcont = get_position() + 32 * dir
	
	dir = Vector2(0, 0)
	if Input.is_action_pressed("left"):
		dir = Vector2(-1, 0)
		set_flip_h(true)
		set_rotation(0)
	elif Input.is_action_just_pressed("right"):
		dir = Vector2(1, 0)
		set_flip_h(false)
		set_rotation(0)
	elif Input.is_action_just_pressed("up"):
		dir = Vector2(0, -1)
		set_flip_h(false)
		set_rotation(80.1)
	elif Input.is_action_just_pressed("down"):
		dir = Vector2(0, 1)
		set_flip_h(false)
		set_rotation(-80.1)
###################FIMMOVIMENTACAODIRECAO###############
