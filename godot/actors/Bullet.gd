extends Area2D

export var speed : int = 200

func _process(delta):
	var dir = Vector2(sin(rotation), -cos(rotation))
	position += dir*delta*speed
