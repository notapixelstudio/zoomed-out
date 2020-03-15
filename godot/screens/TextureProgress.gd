extends TextureProgress

var timer = 0.0
export var rate : float = 1.0

func _process(delta):
	timer += delta
	if timer >= rate:
		timer -= rate
		decrease_bar(1)
	
func decrease_bar(quantity):
	value -= quantity

func increase_bar(quantity):
	value += quantity
