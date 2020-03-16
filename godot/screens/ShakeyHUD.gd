extends Node2D
export var shake_power = 4
export var shake_time = 0.4
var isShake = false
var curPos
var elapsedtime = 0

func _ready():
	randomize()
	curPos = position

func _process(delta):
	if isShake:
		shake_process(delta)    

func _input(event):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and not isShake:
		elapsedtime = 0
		isShake = true

func shake_process(delta):
	if elapsedtime<shake_time:
		position =  Vector2(randf(), randf()) * shake_power
		elapsedtime += delta
	else:
		isShake = false
		elapsedtime = 0
		position = curPos     
		
func shake():
	elapsedtime = 0
	isShake = true
