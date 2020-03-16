extends KinematicBody2D

class_name Lion

export var speed = 60

func _process(delta):
	move_and_slide(Vector2(0,speed))
	
