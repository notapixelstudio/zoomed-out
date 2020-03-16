extends AnimationTree

onready var state_machine = get('parameters/playback')
var old_state = null

signal transition

func get_current_state():
	return state_machine.get_current_node()
	
func travel(to):
	state_machine.travel(to)
	
func update(delta):
	var state = get_current_state()
	if not state:
		return
			
	# transition
	if state != old_state:
		if old_state:
			var old_node = get_node(old_state)
			if old_node:
				old_node.exit(state)
			
		var new_node = get_node(state)
		if new_node:
			new_node.enter(old_state)
			
		emit_signal("transition", old_state, state)
		
		old_state = state
		
	# update current state
	var state_node = get_node(state)
	if not state_node:
		return
		
	state_node.update(delta)
	
