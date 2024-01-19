extends Node2D
var score = 0
var lives = 3

@onready var livesUI = $UI/Hearts
@onready var scoreUI = $UI/Score

func _ready():
	pass

func _physics_process(delta):
	roll("enemy")

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
	
func roll(type):
	pass
