extends Camera2D

func _physicsprocess(delta):
	Camera2D.position.y = Player.position.y
	Camera2D.position.x = 0

