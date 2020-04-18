extends Node2D

var score = 0 setget set_score
onready var lives = 3 setget set_lives

func set_score(value):
	score = value 
	$HUD/Score.set_text("SCORE: " +str(score))
	pass


func set_lives(value):
	lives = value 
	$HUD/Lives.set_text("Lives: "+str(lives))
	#if lives <= 0:
	pass
