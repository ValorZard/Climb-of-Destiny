extends Camera2D

onready var player = get_tree().current_scene.get_node("Player")

func _process(delta):
	position.y = player.get_global_position().y - 300
	position.x = 0

