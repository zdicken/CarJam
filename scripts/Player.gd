extends CharacterBody2D
var lane = 2
var change = 0
var cooled = true

func _input(event):
	if change == 0:
		if Input.is_action_just_pressed("down") and lane < 3:
			change = 1
		elif Input.is_action_just_pressed("up") and lane > 1:
			change = -1
	if Input.is_action_just_pressed("hit") and cooled == true:
		cooled = false
		$Ninja.play("hit")
		$Sword/CollisionShape2D.disabled = false
		await get_tree().create_timer(.5).timeout
		$Sword/CollisionShape2D.disabled = true
		$Ninja.play("default")
		await get_tree().create_timer(.1).timeout
		cooled = true
			
func _physics_process(_delta):
	if change != 0:
		var lanePos = 350 + (lane-1)*100 + change*100
		if (change == 1 and position.y <= lanePos) or (change == -1 and position.y >= lanePos):
			#$PlayerArea.position.y = lanePos
			velocity.y += change-(position.y-lanePos)
		else:
			lane += change
			z_index = lane
			change = 0
			velocity.y = 0
	move_and_slide()
