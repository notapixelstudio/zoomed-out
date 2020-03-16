extends KinematicBody2D

class_name Spider


export var bullet_scene : PackedScene

signal spawn_bullet
const speed = 200
onready var anim = $AnimatedSprite
onready var debug = $Debug

func shoot(how_many):
	for i in how_many:
		var bullet = bullet_scene.instance()
		emit_signal("spawn_bullet", bullet)
		# will be taken care from World.
	# logic for shooting, with pattern
	return
