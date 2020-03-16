extends KinematicBody2D

class_name Hero

const speed = 400
onready var anim = $AnimatedSprite
onready var debug = $Debug
onready var state_machine = $StateMachine

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
var move_direction = Vector2(0,0)

func _process(delta):
	state_machine.update(delta)
	
	var last_move_direction = move_direction
	move_direction = Vector2(0,0)
	
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
		
	if last_move_direction != move_direction:
		if move_direction == Vector2.ZERO:
			anim.play('idle_'+aim)
		else:
			anim.play(states[int(abs(move_direction.x))][int(move_direction.y)])
		
	move_and_slide(move_direction.normalized() * speed)

func hurt(quantity):
	emit_signal("hurt", quantity)

func _on_StateMachine_transition(from, to):
	debug.text = to
	
func color(c):
	anim.modulate = c
	
