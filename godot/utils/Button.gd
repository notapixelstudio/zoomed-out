extends TextureButton

export var normal_texture : Texture
export var hover_texture : Texture

onready var sprite = $Sprite

func _ready():
	sprite.texture = normal_texture
	
func _on_Play_focus_entered():
	sprite.texture = hover_texture
	$Hover.play()


func _on_Play_mouse_entered():
	sprite.texture = hover_texture
	$Hover.play()


func _on_Play_pressed():
	sprite.texture = hover_texture
	$Press.play()


func _on_Play_mouse_exited():
	sprite.texture = normal_texture


func _on_Play_focus_exited():
	sprite.texture = normal_texture
