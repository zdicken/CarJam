extends Node2D

func _on_start_button_pressed():
	get_tree().change_scene_to_file("main.tscn")
	
func _on_end_button_pressed():
	get_tree().quit()
