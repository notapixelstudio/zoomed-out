extends KinematicBody2D

class_name Hero

const speed = 400
onready var anim = $AnimatedSprite
onready var anim_white = $AnimatedSpriteWhite
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

func _ready():
	animated_sprites_play('idle_down')

func _process(delta):
	state_machine.update(delta)
	
	if state_machine.get_current_state() == 'Death' or state_machine.get_current_state() == 'None':
		return
		
		
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
		anim_white.flip_h = anim_white.flip_h
	elif move_direction.x == 1:
		anim.flip_h = false
		anim_white.flip_h = false
	else:
		anim.flip_h = true
		anim_white.flip_h = true
		
	if last_move_direction != move_direction:
		if move_direction == Vector2.ZERO:
			animated_sprites_play('idle_'+aim)
		else:
			animated_sprites_play(states[int(abs(move_direction.x))][int(move_direction.y)])
		
	move_and_slide(move_direction.normalized() * speed)

func hurt(quantity):
	emit_signal("hurt", quantity)

signal died
func die():
	anim.modulate = Color(1,1,1,1)
	state_machine.travel('Death')
	
func _on_StateMachine_transition(from, to):
	debug.text = to
	
	if from == 'Death':
		emit_signal('died')
	
func color(c):
	anim.modulate = c
	
func animated_sprites_play(sth):
	anim.frame = 0
	anim_white.frame = 0
	anim.play(sth)
	anim_white.play(sth)
	
