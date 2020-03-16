extends State

func update(delta):
	if this.move_direction == Vector2(0,0):
		state_machine.travel('Idle')
