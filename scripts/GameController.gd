extends Node2D

const DEFAULT_SPEED = 8

var score = 0
var lives = 3
var speed = DEFAULT_SPEED
var enemyTimer = 30
var heartTimer = 300

@onready var livesUI = $UI/Hearts
@onready var scoreUI = $UI/Score

func _ready():
	pass

func _physics_process(_delta):
	if(enemyTimer <= 0):
		roll("enemy", 8)
		enemyTimer = 30
	elif(heartTimer <= 0):
		roll("life", 20)
		heartTimer = 300
	else:
		roll("obstacle", 2)
	
	if(speed < 16):
		speed += 0.0015
		
	enemyTimer -= 1
	heartTimer -= 1

func changeLives(change):
		lives += change
		if(change <= 0):
			speed = DEFAULT_SPEED
			if(lives <= 1):
				var image = get_viewport().get_texture().get_image()
				var texture = ImageTexture.create_from_image(image)
				#transitionObject.texture = texture
		if(lives > 3):
			lives = 3
		for j in 3:
			livesUI.get_child(j).visible = true
		for j in 3 - lives:
			livesUI.get_child(j).visible = false

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
		"friend":
			pass
		"life":
			new = preload("res://scenes/heart.tscn").instantiate()
	if(number < required):
		new.position.y = 350 + (randi_range(1,3)-1)*100
		new.position.x = 1300
		get_tree().root.add_child(new)
