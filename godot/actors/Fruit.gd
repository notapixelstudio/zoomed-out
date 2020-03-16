tool
extends Area2D

class_name Fruit

onready var animation_player = $AnimationPlayer

var colored = false
export var point = 10

const fruits_data = [
	{'texture': 'apple', 'color': Color('#ff4c4c')},
	{'texture': 'banana', 'color': Color('#ffdc4c')},
	{'texture': 'tangerine', 'color': Color('#ffa04c')},
	{'texture': 'grapes', 'color': Color('#c96ba6')},
	{'texture': 'pineapple', 'color': Color('#b27263')},
	{'texture': 'pear', 'color': Color('#6ec461')},
	{'texture': 'plum', 'color': Color('#617dc4')}
]
enum types {apple, banana, tangerine, grapes, pineapple, pear, plum}
export (types) var type = types.apple setget set_type

func set_type(value):
	type = value
	if not is_inside_tree():
		yield(self, 'ready')
		
	$Sprite.texture = load('res://assets/fruits/'+fruits_data[type]['texture']+'.png')

signal touched

func _on_Fruit_body_entered(body):
	if colored:
		decolor()
		emit_signal('touched')
		
func color():
	colored = true
	modulate = fruits_data[type]['color']
	animation_player.play("blink")
	return fruits_data[type]['color']

func decolor():
	colored = false
	modulate = Color(1,1,1,1)
	
static func get_fruit_color(fruit):
	return fruits_data[fruit]['color']
	
