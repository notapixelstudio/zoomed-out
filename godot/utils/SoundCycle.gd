extends Node


export (Array, AudioStream) var streams
export (String) var bus = 'Master'
var current_index = 0

func _ready():
	for s in streams:
		var asp = AudioStreamPlayer.new()
		asp.stream = s
		asp.bus = bus
		add_child(asp)
		
func play():
	get_child(current_index).play()
	current_index = (current_index + 1) % len(streams)
	# TBD randomize?
