extends KinematicBody2D

class_name Enemy

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var health : int = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if health <= 0:
		self.queue_free()
