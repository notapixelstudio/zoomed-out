extends KinematicBody2D

class_name Lion

export var speed = Vector2(100,0)

var factor = 1.0

func _process(delta):
	move_and_slide(speed*factor)
	if factor > 0.05:
		factor *= 0.98
	else:
		factor = 1.0
		
