extends Area2D

export var speed : int = 200

func _process(delta):
	position.x += speed*delta
