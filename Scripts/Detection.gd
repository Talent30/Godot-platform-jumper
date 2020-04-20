extends Area2D
var player = null



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func can_see(see):
	if player != null:
		see = true
	else:
		see = false
	return see

func _on_Detection_body_entered(body):
	player = body


func _on_Detection_body_exited(body):
	player = null
