extends Control

func _ready():
	$VBoxContainer/startButton.grab_focus()
	$Background.texture = Variables.transitionImage
	$Background.material = load("res://shaders/gameOver.tres")

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	
func _on_end_button_pressed():
	get_tree().quit()
