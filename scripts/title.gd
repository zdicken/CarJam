extends Control

func _ready():
	$startButton.grab_focus()

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	
func _on_end_button_pressed():
	get_tree().quit()
