extends KinematicBody2D

class_name Scorpion

export var speed = 60

func _process(delta):
	move_and_slide(Vector2(0,speed))
	
