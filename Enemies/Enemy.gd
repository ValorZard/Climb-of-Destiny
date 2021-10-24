extends KinematicBody2D

class_name Enemy

export var death_particles : Resource = preload("res://Particles/DeathPoof.tscn");
export var coin_particles : Resource = preload("res://Particles/Coins.tscn");

# todo: animation stuff, just single sprite for now
# depracated
export var sprite : Resource;

# movement / combat variables
export var health : int = 10;
export var damage : int = 1;
export var attack_speed : float = 1.5;
export var move_speed : float = 2;

func Damage(amount):
	health -= amount;
	if(health <= 0):
		Die();

# override this if needed
func Die():
	# death particles
	var death_part_instance = death_particles.instance();
	death_part_instance.emitting = true;
	death_part_instance.transform.origin = transform.origin;
	get_tree().root.add_child(death_part_instance);
	
	var coin_part_instance = coin_particles.instance();
	coin_part_instance.transform.origin = transform.origin;
	get_tree().root.add_child(coin_part_instance);
	
	self.queue_free();
