extends KinematicBody2D

class_name Scorpion

export var speed = 60
export var strength = 5

func _process(delta):
	move_and_slide(Vector2(0,speed))
	
func _on_Area2D_body_entered(body):
	if body is Hero:
		body.hurt(strength)
