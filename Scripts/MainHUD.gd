extends Node2D

var score = 0 setget set_score
var power = 0 setget set_power

func set_score(value):
	score = value 
	$HUD/Score.set_text("SCORE: " +str(score))
	pass


func set_power(value):
	power = value 
	$HUD/Lives.set_text("Lives: "+str(power))
	#if lives <= 0:
	pass
