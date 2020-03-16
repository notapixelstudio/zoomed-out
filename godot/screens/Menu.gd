extends Control

onready var anim = $AnimationPlayer

func _on_Play_pressed():
	$VBoxContainer/Play.disabled = true
	anim.play("Disappear")
	yield(anim, "animation_finished")
	get_tree().change_scene("res://screens/World.tscn")


func _on_Quit_pressed():
	$VBoxContainer/Quit.disabled = true
	anim.play("Disappear")
	yield(anim, "animation_finished")
	get_tree().quit()
