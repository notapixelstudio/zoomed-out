extends KinematicBody2D

class_name SpiderController


export var bullet_scene : PackedScene

signal spawn_bullet
const speed = 200
onready var anim = $AnimatedSprite
onready var debug = $Debug
func _ready():
	yield(get_tree().create_timer(1), "timeout")
	shoot(10)

func shoot(how_many):
	for i in how_many:
		var bullet = bullet_scene.instance()
		bullet.rotation = i*45
		bullet.position = position
		emit_signal("spawn_bullet", bullet)
		# will be taken care from World.
	# logic for shooting, with pattern
	yield(get_tree().create_timer(1.5), "timeout")
	shoot(10)
