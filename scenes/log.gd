extends Area2D

func _physics_process(delta):
	position.x -= 8
	if(position.x < -50):
		get_tree().root.get_node("Game").changeScore(1)
		queue_free()
