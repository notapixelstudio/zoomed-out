extends Node
class_name State

onready var state_machine = get_parent()
onready var this = state_machine.get_parent()

func enter(from):
	pass
	
func update(delta):
	pass
	
func exit(to):
	pass
