extends Area2D

export var speed : int = 200
export var angle : float = 0

func _process(delta):
	position += Vector2(speed*delta,0).rotated(angle)
	
	if position.length() >= 10000:
		queue_free()
