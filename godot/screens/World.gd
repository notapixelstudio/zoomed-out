extends Node2D

onready var colorable_area = $Playfield/ColorableArea
onready var bar = $CanvasLayer/TextureProgress
onready var player = $Hero

var last_chosen_thingy = null

func _ready():
	player.connect("hurt", self, "_on_player_hurt")
	randomize()
	yield(get_tree().create_timer(0.1), "timeout")
	color()

func color():
	# color a random thingy within the colorable area
	var colorable_thingies = colorable_area.get_overlapping_areas()
	
	if len(colorable_thingies) == 0:
		return
		
	var chosen_thingy = colorable_thingies[randi() % len(colorable_thingies)]
	while last_chosen_thingy == chosen_thingy and chosen_thingy is Enemy :
		chosen_thingy = colorable_thingies[randi() % len(colorable_thingies)]
	last_chosen_thingy = chosen_thingy
	
	chosen_thingy.color()
	chosen_thingy.connect('touched', self, '_on_colored_thingy_touched', [chosen_thingy], CONNECT_ONESHOT)

func _on_colored_thingy_touched(thingy):
	bar.increase_bar(thingy.point)
	yield(get_tree().create_timer(0.5), "timeout")
	color()
	
	
func _on_player_hurt(quantity):
	bar.decrease_bar(quantity)
