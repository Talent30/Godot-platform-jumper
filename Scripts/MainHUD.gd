extends Node2D

var score = 0 setget set_score
var power = 0 setget set_power
var life = 3 setget set_life

func set_score(value):
	score = value 
	$HUD/Score.set_text("Score: " +str(score))
	pass


func set_power(value):
	power = value 
	$HUD/Power.set_text("Power: "+str(power))
	#if lives <= 0:
	pass

func set_life(value):
	life = value 
	$HUD/Life.set_text("Life: "+ str(life))
	#if lives <= 0:
	pass
