extends Panel

export (String, FILE, "*.tscn") var skip_to_scene
export (String,FILE,"*.txt") var story_line_file
export (Texture) var person

onready var stsNode = get_node("Skip button")
onready var cbNode = get_node("ChatBox")
onready var pNode = get_node("Person")

func _ready():
	stsNode._loadSkipToScene(skip_to_scene)
	cbNode._loadDialogFromFile(story_line_file)
	pNode.texture = person
	pass
