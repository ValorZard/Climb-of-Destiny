# Patrolling enemies walk back and forth between two points

extends Enemy

class_name PatrollingEnemy

# should be an array of 2 local Vector2 elements
# local for ease of use
export var patrol_locations : Array;

# is patrol_locations converted to global space
# used in movement logic
var global_locations : Array;

# range in movement where enemy changes direction
var buffer_zone : float = 0.25;

# initial target location. randomized in _ready
var next_location := 1;

# movement stuff
# but do we need kinematic body?
var velocity : Vector2 = Vector2.ZERO;
var direction : int = 0;

onready var AttackTimer = $DamageArea/AttackTimer;
var touching_player = false;
var player;

var can_attack = true;

func _ready():
	# start in random facing direction
	# specify instead ?
	#
	# done to avoid monotonous scary drone like behavior
	# all moving in same dir !
	var rng = RandomNumberGenerator.new();
	rng.randomize();
	next_location = rng.randi_range(0, 1);
	
	for location in patrol_locations:
		global_locations.push_back(self.transform.origin + location);

func _physics_process(delta):
	# hard coded that array should be size of 2!
	if global_locations.size() == 2:
		# when enemy reaches buffer zone on either side, switch target location
		if transform.origin.x < global_locations[next_location].x - buffer_zone:
			direction = 1;
			#TODO
			$icon.flip_h = true;
		elif transform.origin.x > global_locations[next_location].x + buffer_zone:
			direction = -1;
			$icon.flip_h = false;
		else:
			next_location = !next_location;
			$icon.flip_h = !$icon.flip_h;
	
	velocity.x = direction * move_speed;
	move_and_slide(velocity, Vector2.UP);

func _process(delta):
	if touching_player && player != null && can_attack:
		AttackTimer.start();
		player.damage(damage);
		can_attack = false;

func _on_DamageArea_body_entered(body):
	if body is Player:
		touching_player = true;
		player = body;

func _on_DamageArea_body_exited(body):
	if body is Player:
		touching_player = false;
		player = null;

func _on_AttackTimer_timeout():
	can_attack = true;
