extends Area2D

var colored = false

signal touched

func _on_Thingy_body_entered(body):
	if colored:
		queue_free()
		emit_signal('touched')
		
func color():
	colored = true
	modulate = Color(1,0,0,1)
	
