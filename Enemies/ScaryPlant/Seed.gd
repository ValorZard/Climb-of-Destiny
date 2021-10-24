extends Area2D

export var move_speed : float = 100;

func _process(delta):
	translate(Vector2(0, move_speed * delta));

func _on_Seed_body_entered(body):
	if body is Player:
		print("player taking dmaage!");
		self.queue_free();

func _on_DeathTimer_timeout():
	queue_free();
