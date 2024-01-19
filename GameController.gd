extends Node2D
var score = 0
var lives = 3

@onready var livesUI = $UI/Hearts
@onready var scoreUI = $UI/Score
@onready var spawner = $Spawner

func _ready():
	pass

func _physics_process(delta):
	roll("obstacle", 2)

func changeLives(change):
		lives += change
		for i in livesUI.get_children():
			for j in 3 - lives:
				livesUI.get_child(j).visible = false

func changeScore(change):
	score += change
	var textScore = str(score)
	while(textScore.length() < 3):
		textScore = "0" + textScore
	scoreUI.text = textScore
	
func roll(type, required):
	var number = randi_range(1, 100)
	var new
	match type:
		"enemy":
			pass
		"obstacle":
			new = preload("res://scenes/log.tscn").instantiate()
		"friend":
			pass
		"life":
			pass
	if(number < required):
		var positionRoll = randi_range(1,3)
		match positionRoll:
			1:
				new.position = spawner.get_child(0).position
			2:
				new.position = spawner.get_child(1).position
			3:
				new.position = spawner.get_child(2).position
		get_tree().root.add_child(new)
