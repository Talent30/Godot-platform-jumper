extends Button


var skip_to_scene

func _loadSkipToScene(scene):
	skip_to_scene = scene


func _pressed():
	get_tree().change_scene(skip_to_scene)
	
