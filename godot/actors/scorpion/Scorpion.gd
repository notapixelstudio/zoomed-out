extends KinematicBody2D

class_name Lion

export var speed = Vector2(60,0)

func _process(delta):
	move_and_slide(speed)
	
