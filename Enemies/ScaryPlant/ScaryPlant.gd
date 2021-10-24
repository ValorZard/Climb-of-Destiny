extends Enemy

var player;
export var rotation_speed : float = 0.5;
export var rotation_offset : float = -PI/2;

export var seed_projectile = preload("res://Enemies/ScaryPlant/Seed.tscn");
export var spine_projectile = preload("res://Enemies/ScaryPlant/Spine.tscn");

# spawn spine parents
onready var left_spine_wing = $Icon/leftwing;
onready var right_spine_wing = $Icon/rightwing;

func _process(delta):
	if(player == null):
		return;
	
	# holy scuff ;-;
	
	#self.look_at(player.transform.origin);
	#self.rotation_degrees -= 90;
	
	smooth_look_at(player, delta);

func _on_PlayerDetectionRadius_body_entered(body):
	if body is Player:
		player = body;

func _on_PlayerDetectionRadius_body_exited(body):
	if body is Player:
		player = null;

# smooth look at by Jason Lothamer
# edited to include rotation_offset
func smooth_look_at(target, delta):
	var v = target.global_position - global_position;
	var r = global_rotation;
	var angle = v.angle();
	var angle_delta = rotation_speed * delta;
	angle = lerp_angle(r, angle + rotation_offset, 1.0);
	angle = clamp(angle, r - angle_delta, r + angle_delta);
	global_rotation = angle;

# shoot particle
func _on_Timer_timeout():
	var seed_instance = seed_projectile.instance();
	seed_instance.transform.origin = transform.origin;
	seed_instance.rotation_degrees = rotation_degrees;
	get_tree().root.add_child(seed_instance);
	
	$ShootParticles.emitting = true;

func _on_SpineWaveTimer_timeout():
	var wings = [right_spine_wing, left_spine_wing];
	
	for wing in wings:
		for spawner in wing.get_children():
			var spine_instance = spine_projectile.instance();
			spine_instance.global_position = spawner.global_position;
			spine_instance.rotation_degrees = rotation_degrees;
			get_tree().root.add_child(spine_instance);
