extends Camera2D

onready var player = get_node("../Player")

func _process(delta):
	self.position.y = player.get_global_position().y - 300
	self.position.x = 0

