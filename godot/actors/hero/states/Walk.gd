extends State

func enter(from):
	this.anim.play(this.states[int(abs(this.move_direction.x))][int(this.move_direction.y)])
	
func update(delta):
	if this.move_direction == Vector2(0,0):
		state_machine.travel('Idle')
