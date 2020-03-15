extends KinematicBody2D

class_name Hero

const speed = 400
onready var anim = $AnimatedSprite
onready var debug = $Debug

var last_one = Vector2.ZERO

signal hurt 

const states = {
	0: {-1: "walk_up",
		1: "walk_down",
		0: "idle_"},
	1: {-1: "walk_up_45",
		0: "walk_horiz",
		1: "walk_down_45"}
	
}

var aim = "up" # or down

func _process(delta):
	var move_direction = Vector2(0,0)
	
	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")
	var up  = Input.is_action_pressed("ui_up")
	var down = Input.is_action_pressed("ui_down")
	
	if left:
		move_direction += Vector2(-1,0)
	if right:
		move_direction += Vector2(1,0)
	if up:
		move_direction += Vector2(0,-1)
		aim = "up"
	if down:
		move_direction += Vector2(0,1)
		aim = "down"
	
	if move_direction.x == 0:
		anim.flip_h = anim.flip_h
	elif move_direction.x == 1:
		anim.flip_h = false
	else: 
		anim.flip_h = true
		
	
	if last_one != move_direction:
		last_one = move_direction
		var state_name = states[int(abs(last_one.x))][int(last_one.y)]
		if state_name == "idle_":
			state_name = state_name + aim
		anim.play(state_name)
		debug.text = state_name
		
	move_and_slide(move_direction.normalized() * speed)

func hurt(quantity):
	emit_signal("hurt", quantity)
