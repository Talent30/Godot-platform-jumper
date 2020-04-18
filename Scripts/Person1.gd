extends Area2D

onready var sbNode = get_node("StoryBox")

#called when the node enters the scene tree of the first
func _ready():
	pass
	
func _process(delta):
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body.name == "Player":
			$StoryBox.visible = true
	pass
	


func _on_Person1_body_exited(body):
	if body.name == "Player":
		$StoryBox.visible = false
	pass # Replace with function body.
