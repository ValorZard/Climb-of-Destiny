extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var bullet_prefab := preload("res://Bullets/Bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if $Timer.is_stopped():
		var bullet_position = Vector2(rand_range(0, 1000), rand_range(0, 500))
		var bullet := bullet_prefab.instance()
		get_tree().current_scene.get_node("Bullets").add_child(bullet)
		bullet.position = bullet_position
		var velocity : Vector2 = Vector2(1, 1) * 50
		bullet.velocity = velocity
