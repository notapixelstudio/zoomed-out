extends State

func enter(from):
	this.anim.play('idle_down')

#func update(delta):
#	if this.move_direction != Vector2(0,0):
#		state_machine.travel('Walk')
