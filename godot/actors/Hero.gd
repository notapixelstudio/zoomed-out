extends KinematicBody2D

const speed = 200

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
	if down:
		move_direction += Vector2(0,1)
	
	move_and_slide(move_direction.normalized() * speed)
	
