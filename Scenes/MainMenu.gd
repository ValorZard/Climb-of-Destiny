extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/StartButton


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartButton_pressed():
	get_tree().change_scene("res://Scenes/Level1.tscn")


func _on_CreditButton_pressed():
	pass # get_tree().change_scene("Credit Scene")


func _on_QuitButton_pressed():
	get_tree().quit()
