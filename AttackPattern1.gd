extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var bullet_prefab := preload("res://Bullets/Bullet.tscn")
var bullet_array : Array
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	"""
	if $Timer.is_stopped():
		var bullet_position = Vector2(rand_range(-500, 500), rand_range(-500, 500))
		# up left side of circle
		var i : int = 0
		while i <= 5:
			var bullet := bullet_prefab.instance()
			get_tree().current_scene.get_node("Bullets").add_child(bullet)
			bullet.position = bullet_position
			var velocity : Vector2 = Vector2(-cos(deg2rad(90/5) * i), sin(deg2rad(90/5) * i)) * 50
			bullet.velocity = velocity
			i += 1
		# up right side of circle
		i = 0
		while i <= 5:
			var bullet := bullet_prefab.instance()
			get_tree().current_scene.get_node("Bullets").add_child(bullet)
			bullet.position = bullet_position
			var velocity : Vector2 = Vector2(cos((deg2rad(90/5) * i)), sin(deg2rad(90/5) * i)) * 50
			bullet.velocity = velocity
			i += 1
		# down left side of circle
		i = 0
		while i <= 5:
			var bullet := bullet_prefab.instance()
			get_tree().current_scene.get_node("Bullets").add_child(bullet)
			bullet.position = bullet_position
			var velocity : Vector2 = Vector2(-cos(deg2rad(90/5) * i), -sin(deg2rad(90/5) * i)) * 50
			bullet.velocity = velocity
			i += 1
		# down right side of circle
		i = 0
		while i <= 5:
			var bullet := bullet_prefab.instance()
			get_tree().current_scene.get_node("Bullets").add_child(bullet)
			bullet.position = bullet_position
			var velocity : Vector2 = Vector2(cos((deg2rad(90/5) * i)), -sin(deg2rad(90/5) * i)) * 50
			bullet.velocity = velocity
			i += 1
		$Timer.start()
		"""
	pass
