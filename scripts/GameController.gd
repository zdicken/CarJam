extends Node2D

const DEFAULT_SPEED = 8

var score = 0
var lives = 3
var speed = DEFAULT_SPEED
var enemyTimer = 30
var heartTimer = 300
var windowTimer = 100

@onready var livesUI = $UI/Hearts
@onready var scoreUI = $UI/Score

func _physics_process(_delta):
	if(enemyTimer <= 0):
		roll("enemy", 8)
		enemyTimer = 30
	elif(heartTimer <= 0):
		roll("life", 20)
		heartTimer = 300
	else:
		roll("obstacle", 2)
	
	if(windowTimer <= 0):
		var windowScene = preload("res://scenes/window.tscn")
		var window = windowScene.instantiate()
		window.position = Vector2(get_viewport_rect().size.x,150)
		add_child(window)
		windowTimer = 100
	
	if(speed < 16):
		speed += 0.0015
		
	enemyTimer -= 1
	heartTimer -= 1
	windowTimer -= 1

func changeLives(change):
		lives += change
		if(lives > 3):
			lives = 3
		for j in 3:
			livesUI.get_child(j).visible = true
		for j in 3 - lives:
			livesUI.get_child(j).visible = false
		await get_tree().create_timer(.2).timeout
		if(change <= 0):
			speed = DEFAULT_SPEED
			if(lives < 1):
				var image = get_viewport().get_texture().get_image()
				var texture = ImageTexture.create_from_image(image)
				Variables.transitionImage = texture
				get_tree().change_scene_to_file.bind("res://scenes/gameOver.tscn").call_deferred()

func changeScore(change):
	score += change
	if(score < 0):
		score = 0
	var textScore = str(score)
	while(textScore.length() < 3):
		textScore = "0" + textScore
	scoreUI.text = textScore
	
func roll(type, required):
	var number = randi_range(1, 100)
	var new
	match type:
		"enemy":
			new = preload("res://scenes/enemy.tscn").instantiate()
		"obstacle":
			new = preload("res://scenes/log.tscn").instantiate()
		#"friend":
		#	pass
		"life":
			new = preload("res://scenes/heart.tscn").instantiate()
	if(number < required):
		var newLane = randi_range(1,3)
		new.position.y = 350 + (newLane-1)*100
		new.position.x = 1300
		new.z_index = newLane
		add_child(new)
