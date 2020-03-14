extends Area2D

onready var animation_player = $AnimationPlayer

var colored = false
export var point = 3

signal touched

func _on_Thingy_body_entered(body):
	if colored:
		decolor()
		emit_signal('touched')
		
func color():
	colored = true
	modulate = Color(1,0,0,1)
	animation_player.play("blink")

func decolor():
	colored = false
	modulate = Color(1,1,1,1)
	
