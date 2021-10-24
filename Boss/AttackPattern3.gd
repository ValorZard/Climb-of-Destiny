extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var wave : PackedScene = preload("res://Boss/Wave.tscn")

var waves : Array = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if len(waves) != 0:
		waves[0].position += Vector2(-100, 0) * delta
		waves[1].position += Vector2(100, 0) * delta


func _on_Timer_timeout():
	print("waves dont lie")
	var wave_left = wave.instance()
	wave_left.position = Vector2(450, 450)
	waves.append(wave_left)
	get_tree().current_scene.get_node("Bullets").add_child(wave_left)
	var wave_right = wave.instance()
	wave_right.position = Vector2(500, 450)
	waves.append(wave_right)
	get_tree().current_scene.get_node("Bullets").add_child(wave_right)
