extends CharacterBody2D
var lane = 2
var change = 0

func _input(event):
	if change == 0:
		if Input.is_action_just_pressed("down") and lane < 3:
			change = 1
		elif Input.is_action_just_pressed("up") and lane > 1:
			change = -1
			
func _physics_process(delta):
	if change != 0:
		var lanePos = 350 + (lane-1)*100 + change*100
		if (change == 1 and position.y <= lanePos) or (change == -1 and position.y >= lanePos):
			#$PlayerArea.position.y = lanePos
			velocity.y += change-(position.y-lanePos)
		else:
			lane += change
			change = 0
			velocity.y = 0
	move_and_slide()
