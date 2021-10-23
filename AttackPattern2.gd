extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var bullet_prefab := preload("res://Bullets/Bullet.tscn")
var player : Player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("Player")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if $Timer.is_stopped():
		var bullet_position := Vector2(rand_range(0, 1000), rand_range(0, 500))
		while((bullet_position.x <= player.position.x + 50 and bullet_position.x >= player.position.x - 50) 
		or (bullet_position.y <= player.position.y + 50 and bullet_position.y >= player.position.y - 50)):
			bullet_position = Vector2(rand_range(0, 1000), rand_range(0, 500))
		var bullet := bullet_prefab.instance()
		get_tree().current_scene.get_node("Bullets").add_child(bullet)
		bullet.position = bullet_position
		var velocity : Vector2 = Vector2(1, 1) * 50
		bullet.velocity = velocity
