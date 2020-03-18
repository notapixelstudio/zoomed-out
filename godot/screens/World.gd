extends Node2D

onready var colorable_area = $Areas/ColorableArea
onready var colorable_area_shape = $Areas/ColorableArea/CollisionShape2D
onready var bar = $CanvasLayer/PlayerHUD/BarProgress
onready var player = $Playfield/Hero
onready var playfield = $Playfield
onready var bucket_head = $CanvasLayer/PlayerHUD/BucketGuyHead
onready var pickup_sound_cycle = $PickupSoundCycle
onready var camera = $Areas/Camera2D
onready var player_hud = $CanvasLayer/PlayerHUD
onready var canvas = $CanvasLayer
onready var gameover = $CanvasLayer/GameOver

var next_color = Fruit.get_fruit_color(Fruit.types.apple)

var next_fruit_type = Fruit.types.apple
var last_chosen_thingy = null

func _ready():
	for shooter in get_tree().get_nodes_in_group("shooting"):
		shooter.connect("spawn_bullet", self, "spawn_bullet")
	player.connect("hurt", self, "_on_player_hurt")
	randomize()
	yield(get_tree().create_timer(0.1), "timeout")
	color()

func color():
	bar.tint_progress = next_color
	bucket_head.modulate = next_color
	player.color(next_color)
	
	yield(get_tree().create_timer(1), "timeout")
	
	# color a random thingy within the colorable area
	var colorable_thingies = colorable_area.get_overlapping_areas()
	
	if len(colorable_thingies) == 0:
		return
		
	var chosen_thingy = colorable_thingies[randi() % len(colorable_thingies)]
	while last_chosen_thingy == chosen_thingy or not chosen_thingy.is_in_group('colorable') or chosen_thingy.type != next_fruit_type:
		chosen_thingy = colorable_thingies[randi() % len(colorable_thingies)]
	last_chosen_thingy = chosen_thingy
	
	next_color = chosen_thingy.color()
	chosen_thingy.connect('touched', self, '_on_colored_thingy_touched', [chosen_thingy], CONNECT_ONESHOT)
	
func _on_colored_thingy_touched(thingy):
	bar.increase_bar(thingy.point)
	pickup_sound_cycle.play()
	color()
	
func _on_player_hurt(quantity):
	player_hud.shake()
	print("player got hurt for "+ str(quantity))
	bar.decrease_bar(quantity)

func game_over():
	gameover.initialize()
	get_tree().paused = true
	
	
func _on_TextureProgress_value_changed(value):
	if value <= 0:
		player.die()
		yield(player, 'died')
		game_over()

func get_playfield_extents():
	return Vector2(512*camera.zoom.x, 300*camera.zoom.y) # warning: hardcoded

# scorpion spawning
var scorpion_scene = preload('res://actors/crab/Crab.tscn')

func spawn_scorpion():
	var scorpion = scorpion_scene.instance()
	scorpion.position.x = -get_playfield_extents().x*1.2
	scorpion.position.y = player.position.y
	playfield.add_child(scorpion)

# lion spawning
var lion_scene = preload('res://actors/lion/Lion.tscn')

func spawn_lion():
	var lion = lion_scene.instance()
	lion.position.x = player.position.x
	lion.position.y = -get_playfield_extents().y*1.2
	playfield.add_child(lion)


func _on_Spider_spawn_bullet(bullet):
	add_child(bullet)
	
func advance_fruit_type():
	next_fruit_type = min(next_fruit_type+1, len(Fruit.types))
	bar.max_value += 2

func back_with_fruit_type():
	next_fruit_type = max(next_fruit_type-1, 0)
