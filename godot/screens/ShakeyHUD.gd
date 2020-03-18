extends Node2D

export var shake_power = 4
export var shake_time = 0.4

var timeformat = "{min}:{sec}"
onready var timelabel = $TimePassed

var stop = false
var time = 0.0
var isShake = false
var curPos
var elapsedtime = 0

func _ready():
	randomize()
	curPos = position

func stop_timer():
	stop = true
	
func sec_to_min(seconds: float) -> String:
	var m = int(floor(seconds/60))
	var s = int(floor(seconds))%60
	var ss: String = "0"+str(s) if s < 10 else str(s)
	return timeformat.format({"min": m, "sec": ss})
	
func _process(delta):
	if isShake:
		shake_process(delta)    
	if stop:
		return
	time+=delta
	timelabel.text = sec_to_min(time)
	
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
