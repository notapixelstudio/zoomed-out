tool
extends Area2D

class_name Fruit

onready var animation_player = $AnimationPlayer
onready var sprite = $Sprite
onready var halo = $circle

var colored = false
export var point = 100

const fruits_data = [
	{'texture': 'apple', 'color': Color('#ff4c4c')},
	{'texture': 'tangerine', 'color': Color('#ffa04c')},
	{'texture': 'banana', 'color': Color('#ffdc4c')},
	{'texture': 'pear', 'color': Color('#6ec461')},
	{'texture': 'plum', 'color': Color('#617dc4')},
	{'texture': 'grapes', 'color': Color('#c96ba6')},
	{'texture': 'pineapple', 'color': Color('#b27263')}
]
enum types {apple, tangerine, banana, pear, plum, grapes, pineapple}
export (types) var type = types.apple setget set_type

func set_type(value):
	type = value
	if not is_inside_tree():
		yield(self, 'ready')
		
	$Sprite.texture = load('res://assets/fruits/'+fruits_data[type]['texture']+'.png')

signal touched

func _on_Fruit_body_entered(body):
	if not body is Hero:
		return
		
	if colored:
		decolor()
		emit_signal('touched')
		
func color():
	colored = true
	sprite.modulate = fruits_data[type]['color']
	halo.modulate = fruits_data[type]['color']
	animation_player.play("blink")
	return fruits_data[type]['color']

func decolor():
	colored = false
	animation_player.play("idle")
	sprite.modulate = Color(1,1,1,1)
	halo.modulate = Color(1,1,1,1)
	
static func get_fruit_color(fruit):
	return fruits_data[fruit]['color']
	
