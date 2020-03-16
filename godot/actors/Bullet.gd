extends Area2D

export var speed : int = 300
export var angle : float = 0
export var strength = 5

func _process(delta):
	position += Vector2(speed*delta,0).rotated(angle)
	
	if position.length() >= 10000:
		queue_free()

func _on_Bullet_body_entered(body):
	if body is Hero:
		body.hurt(strength)
