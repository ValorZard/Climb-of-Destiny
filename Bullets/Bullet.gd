extends Area2D

class_name Bullet

var bullet_velocity := Vector2.ZERO
var damage : int = 10

#var node_shot_from : Node # the owner of this node

func _on_DespawnTimer_timeout():
	destroy_self()

func _on_Bullet_body_entered(body):
	if body is Enemy:
		body.Damage(1)
	if !body.is_in_group("Bullets"):
		destroy_self()

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Bullets")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	self.position += bullet_velocity * delta

func destroy_self():
	self.queue_free()

func set_velocity(vel: Vector2):
	bullet_velocity = vel
