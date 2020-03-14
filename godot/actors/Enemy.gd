extends Area2D

class_name Enemy

export var strength = 2

func _on_Node2D_body_entered(body):
	if body is Hero:
		body.hurt(strength)
