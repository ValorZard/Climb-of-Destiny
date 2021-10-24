extends Area2D

export var move_speed : float = 100;
export var damage : int = 10;

func _process(delta):
	position += -Vector2.UP.rotated(rotation) * move_speed * delta;

func _on_Seed_body_entered(body):
	if body is Player:
		body.damage(damage);
		self.queue_free();

func _on_DeathTimer_timeout():
	queue_free();
