extends Area2D
@onready var speed = get_tree().root.get_node("Game").speed + randi_range(-0.5,0)

func _physics_process(delta):
	position.x -= speed
	if(position.x < -50):
		queue_free()
		
func onHit():
	get_tree().root.get_node("Game").changeScore(5)

func _on_area_entered(area):
	if(area.name == "PlayerArea"):
		get_tree().root.get_node("Game").changeLives(1)
		queue_free()
