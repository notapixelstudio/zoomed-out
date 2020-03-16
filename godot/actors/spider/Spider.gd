extends KinematicBody2D

class_name Spider


export var bullet_scene : PackedScene
export var strength = 10

signal spawn_bullet

onready var timer = $Timer
onready var state_machine = $StateMachine

func shoot(how_many):
	for i in how_many:
		var bullet = bullet_scene.instance()
		bullet.position = position
		bullet.angle = 2*PI/how_many*i
		emit_signal("spawn_bullet", bullet)
		# will be taken care from World.


func _on_screen_entered():
	state_machine.travel('Idle')
	
func _on_Area2D_body_entered(body):
	if body is Hero:
		body.hurt(strength)
