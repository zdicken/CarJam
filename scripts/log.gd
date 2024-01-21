extends Area2D
@onready var speed = get_tree().root.get_node("Game").speed + randi_range(-0.5,0.5)

func _physics_process(delta):
	position.x -= speed
	if(position.x < -50):
		get_tree().root.get_node("Game").changeScore(1)
		queue_free()


func _on_body_entered(body):
	if(body.name == "Player"):
		get_tree().root.get_node("Game").changeLives(-1)
		queue_free()
