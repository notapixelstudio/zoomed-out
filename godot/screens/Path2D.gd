extends Path2D

onready var follow = $PathFollow2D
var speed = 120

func _process(delta):
	follow.offset += speed*delta
