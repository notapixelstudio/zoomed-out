extends KinematicBody2D

class_name Spider


export var bullet_scene : PackedScene

signal spawn_bullet

onready var anim = $AnimatedSprite

func shoot(how_many):
	for i in how_many:
		var bullet = bullet_scene.instance()
		emit_signal("spawn_bullet", bullet)
		# will be taken care from World.
	# logic for shooting, with pattern
	return
