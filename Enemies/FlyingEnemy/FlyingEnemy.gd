extends Enemy

class_name FlyingEnemy

# erratic movement -> flies in circles as it approaches target

# circle spin speed
export var erratic_movement_level : float = 0.5;

# circle size
export var erratic_movement_amount : float = 10;

# ensure no jitters when on same axis as player
export var buffer_zone : float = 1;

var velocity : Vector2 = Vector2.ZERO;
var player;
var rng : RandomNumberGenerator;
var clock : float = 0;

func _ready():
	rng = RandomNumberGenerator.new();
	rng.randomize();

func _physics_process(delta):
	if player == null:
		return;
	
	# tick clock for MATHS
	clock += delta;
	
	# align direction with player
	if(player.transform.origin.x - buffer_zone > transform.origin.x):
		velocity.x = 1;
	elif(player.transform.origin.x + buffer_zone < transform.origin.x):
		velocity.x = -1;
	else:
		velocity.x = 0;
	if(player.transform.origin.y - buffer_zone > transform.origin.y):
		velocity.y = 1;
	elif(player.transform.origin.y + buffer_zone < transform.origin.y):
		velocity.y = -1;
	else:
		velocity.y = 0;
	
	# use ms to speed up/slow
	velocity *= move_speed;
	
	# add erratic movement
	velocity += Vector2(sin(clock * erratic_movement_level) * erratic_movement_amount, cos(clock * erratic_movement_level) * erratic_movement_amount);
	
	velocity = move_and_slide(velocity, Vector2.UP);

func _on_PlayerDetectionRadius_body_entered(body):
	if body is Player:
		player = body;

func _on_PlayerDetectionRadius_body_exited(body):
	if body is Player:
		player = null;
