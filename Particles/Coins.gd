# delays turning itself on

extends Particles2D

func _on_Timer_timeout():
	self.emitting = true;
