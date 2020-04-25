extends Node2D


func _ready():
	$MarginContainer/VBoxContainer/VBoxContainer2/TextureButton.grab_focus()
	OS.set_window_position(OS.get_screen_size()*0.5 - OS.get_window_size()*0.5)
	


func _physics_process(_delta):
	if $MarginContainer/VBoxContainer/VBoxContainer2/TextureButton.is_hovered() == true:
		$MarginContainer/VBoxContainer/VBoxContainer2/TextureButton.grab_focus()
	if $MarginContainer/VBoxContainer/VBoxContainer2/TextureButton2.is_hovered() == true:
		$MarginContainer/VBoxContainer/VBoxContainer2/TextureButton2.grab_focus()
	



func _on_TextureButton_pressed():
	get_tree().change_scene("res://Scenes/World1.tscn")


func _on_TextureButton2_pressed():
	get_tree().quit()
