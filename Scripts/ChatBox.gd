extends Label 

var drawTextSpeed: int = 0
var chatterLimit: int = 100 #max characters in chatbox
var dialog = [] # list of story lines

var page = 0

func _loadDialogFromFile(fname):
	var f = File.new()
	f.open(fname, File.READ)
	var index =1
	while not f.eof_reached():
		var line = f.get_line()
		dialog.append(line)
		index+=1
	f.close()
	
	#initialise first line of chat and set the chat box text
	set_text(dialog[page])
	pass
	
func _ready():
	pass

# print story line by line
func _showChatter():
	if drawTextSpeed < chatterLimit:#print 1 char at a time
		drawTextSpeed +=  1
		self.visible_characters = drawTextSpeed
	pass

func _process(_delta):
	_showChatter()
	pass
	
	


func _on_Continue_button_pressed():
	if page < dialog.size()-1:
		page +=1
		set_text(dialog[page])
	else:
		page = 0
		set_text(dialog[page])
	#reset chatter box method to show new chat line
	drawTextSpeed = 0
	_showChatter()
	pass # Replace with function body.
	pass # Replace with function body.
