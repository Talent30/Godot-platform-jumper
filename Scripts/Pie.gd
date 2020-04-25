extends "res://Scripts/MainHUD.gd"

func _on_Pie_body_entered(body):
	if body.name == "Player":
		get_node("/root/MainHUD").score += 5
		get_node("/root/MainHUD").power += 1
		queue_free()
	pass # Replace with function body.
