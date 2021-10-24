extends Enemy

onready var AttackTimer = $Damage/AttackTimer;
onready var MoveTimer = $MoveTimer;

var can_attack = true;
var player = null;
var player_range = false;

# movement
var locations : Array;
export var node_parent : NodePath;
var next_location : int = 0;
var buffer_zone : float = 3.0;

# spit
onready var spit = preload("res://Enemies/Spider/WebSpit.tscn");

var rng : RandomNumberGenerator;
var velocity : Vector2 = Vector2.ZERO;

func _ready():
	AttackTimer.wait_time = attack_speed;
	
	rng = RandomNumberGenerator.new();
	rng.randomize();
	
	for node in get_node(node_parent).get_children():
		locations.push_back(node);

func _process(delta):
	if player != null && can_attack:
		player.damage(damage);
		AttackTimer.start();
		can_attack = false;

func _physics_process(delta):
	if(locations.size() == 0):
		return;
	if transform.origin.x < locations[next_location].transform.origin.x - buffer_zone:
		velocity.x = 1;
	elif transform.origin.x > locations[next_location].transform.origin.x + buffer_zone:
		velocity.x = -1;
	else:
		velocity.x = 0;
	if transform.origin.y < locations[next_location].transform.origin.y - buffer_zone:
		velocity.y = 1;
	elif transform.origin.y > locations[next_location].transform.origin.y + buffer_zone:
		velocity.y = -1;
	else:
		velocity.y = 0;
	
	velocity *= move_speed;
	
	velocity = move_and_slide(velocity, Vector2.UP);

func _on_AttackTimer_timeout():
	can_attack = true;


func _on_Damage_body_entered(body):
	if body is Player:
		player = body;
		player_range = true;


func _on_Damage_body_exited(body):
	if body is Player:
		player_range = false;

func _on_MoveTimer_timeout():
	# move to a new location
	next_location = rng.randi_range(0, locations.size() - 1);
	MoveTimer.wait_time = rng.randi_range(2, 6);
	MoveTimer.start();


func _on_PlayerDetection_body_entered(body):
	if body is Player:
		player = body;



func _on_PlayerDetection_body_exited(body):
	pass;


func _on_SpitTimer_timeout():
	var c = 0;
	while c < rng.randi_range(1, 6):
		c += 1;
		var spit_instance = spit.instance();
		spit_instance.transform.origin = transform.origin;
		spit_instance.look_at(player.transform.origin);
		get_tree().root.add_child(spit_instance);
		$SpitAttackTimer.start();
		yield($SpitAttackTimer, "timeout");
