extends AnimatedSprite

export var iniposdisc = Vector2()
export var color = ""
export var points = 0

var posdisc 
var destdisc
var destcont

var speed

var state
enum {NORMAL, BLUE, DEAD}

func _ready():
	spawn()
	
	set_process(true)


func spawn():
	posdisc = iniposdisc
	destdisc = posdisc
	
	set_position(posdisc * 32 + Vector2(16, 16))
	destcont = get_position()
	
	speed = 140
	
	set_animation(color)
	
	state = NORMAL
	
	
func _process(delta):
	
	var delcont = destcont - get_position()
	if delcont != Vector2(0, 0):
		if delcont.length() < 2:
			set_position(destdisc * 32 + Vector2(16, 16))
			posdisc = destdisc
		else :
			set_position(get_position() + delta * speed * delcont.normalized())
			
	