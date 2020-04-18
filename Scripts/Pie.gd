extends "res://Scripts/MainHUD.gd"

func _on_Pie_body_entered(body):
	if body.name == "Player":
		get_node("/root/MainHUD").score += 5
		queue_free()
	pass # Replace with function body.
