extends KinematicBody2D

class_name Player

export var walk_speed : float = 600
export var walk_acceleration : float = 0.25
export var jump_speed : float = -800
export var gravity : float = 70
export var friction : float = 0.2

export var higher_jump = true
export var glide: bool = false
export var max_air_jumps : int = 1

export var health : int = 100

var current_gravity = gravity
var walk_direction: int = 0
var velocity: Vector2 = Vector2.ZERO
var air_jumps: int = max_air_jumps
var can_shoot: bool = true
# Pressed jump on this frame
var just_jumped: bool = false
var jump_anim_finished: bool = true

var bullet_prefab = preload("res://Bullets/Bullet.tscn")

onready var bullet_timer: Timer = get_node("BulletTimer")
onready var bullet_node: Node = get_tree().get_current_scene().get_node("Bullets")
onready var sprite_node: AnimatedSprite = get_node("AnimatedSprite")
# All bullet spawners that are children of this node
# How do you type this?
#onready var bullet_spawners = get_child_bullet_spawners()


func _on_BulletTimer_timeout():
	can_shoot = true

func _on_AnimatedSprite_animation_finished():
	if sprite_node.get_animation() == "Jump":
		jump_anim_finished = true

func _ready():
	sprite_node.play()
	
	air_jumps = Global.max_player_jumps;
	glide = Global.can_glide;
	higher_jump = Global.upgraded_jump;

func _process(_delta):
	handle_death()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
#	shoot()
	move()
	play_anim()

func damage(dmg):
	health = max(0, health-dmg)
	return health

# Calls each function to manipulate velocity
func move():
	move_horizontal()
	move_gravity()
	move_jump()
	# Add other movement abilities here
	
	# Commit velocities and handle collisions
	velocity = move_and_slide(velocity, Vector2.UP)

func handle_death():
	if health == 0:
		get_tree().change_scene("res://Scenes/Shop.tscn")

"""
# Get all BulletSpawners that are children of this node
func get_child_bullet_spawners():
	var spawners = []
	for child in get_children():
		if child is BulletSpawner:
			spawners.append(child)
	return spawners

# Get BulletSpawner that is closest to cursor
# Add ability to use arrow keys?
func get_closest_bullet_spawner():
	var i_distance: float = INF
	var i_closest: BulletSpawner
	var mouse_pos = get_global_mouse_position()
	for spawner in bullet_spawners:
		var cur_distance = spawner.get_global_position().distance_to(mouse_pos)
		print(cur_distance)
		if cur_distance < i_distance:
			i_distance = cur_distance
			i_closest = spawner
	return i_closest

# Instantiate and set position of bullets each time timer fires
func shoot():
	if Input.is_action_pressed("shoot") and can_shoot:
		get_closest_bullet_spawner().shoot()
		can_shoot = false
		bullet_timer.start(0)
"""
# Can use flip() in the future
func set_sprite_mirror():
	var orig_scale = sprite_node.get_scale()
	var x_scale = -walk_direction * abs(orig_scale.x)
	var y_scale = orig_scale.y
	sprite_node.set_scale(Vector2(x_scale, y_scale))

# Walking/air strafe and friction if not walking
func move_horizontal():
	# Can if function into 'if' if different case needed for air
	# Ex: move_horizontal_ground and move_horizontal_air
	update_walk_direction()
	if walk_direction:
		set_sprite_mirror()
		velocity.x = lerp(velocity.x, walk_direction*walk_speed, walk_acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)

func update_walk_direction():
	walk_direction = 0
	if Input.is_action_pressed("walk_right"):
		walk_direction += 1
	if Input.is_action_pressed("walk_left"):
		walk_direction -= 1
	return walk_direction

func move_gravity():
	velocity.y += current_gravity

func move_jump():
	just_jumped = false
	if is_on_floor():
		air_jumps = max_air_jumps
	if Input.is_action_just_pressed("jump") and air_jumps:
		just_jumped = true
		if higher_jump:
			velocity.y = 1.3 * jump_speed
		else:
			velocity.y = jump_speed
		air_jumps -= 1
	if Input.is_action_pressed("jump"):
		# Moving down, glide
		if velocity.y > 0 and glide:
			current_gravity = 0.03 * gravity
			velocity.y = max(15, velocity.y)
		elif velocity.y < 0:
			current_gravity = 0.3 * gravity
	else:
		current_gravity = gravity

func play_anim():
	if just_jumped:
		jump_anim_finished = false
		sprite_node.play("Jump")
		sprite_node.set_frame(0)
	if not jump_anim_finished:
		return
	if abs(velocity.x) > 100:
		sprite_node.set_animation("Run")
	else:
		sprite_node.set_animation("Idle")
