extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity := Vector2.ZERO
var default_velocity := Vector2(800, 0)
var damage : int = 10
var direction : int = 0

var node_shot_from : Node # the owner of this node

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = default_velocity


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	self.position += velocity * delta
	if direction < 0:
		if velocity.x > 0:
			velocity.x = -velocity.x
	elif direction > 0:
		if velocity.x < 0:
			velocity.x = -velocity.x



func _on_Bullet_body_entered(body):
	if body is Enemy:
		body.health -= 1
	self.queue_free()
