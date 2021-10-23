extends KinematicBody2D
#class_name Player2

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var walk_speed : float = 600
export var walk_acceleration : float = 0.25
export var jump_speed : float = -1000
export var gravity : float = 70
export var friction : float = 0.1

export var max_air_jumps : int = 3


var velocity: Vector2 = Vector2.ZERO
var air_jumps: int = max_air_jumps
var can_shoot: bool = true

var bullet_prefab = preload("res://Bullets/Bullet.tscn")

onready var bullet_timer: Timer = get_node("BulletTimer")
onready var bullet_node: Node = get_tree().get_current_scene().get_node("Bullets")


func _on_BulletTimer_timeout():
	can_shoot = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	move()

	
# Calls each function to manipulate velocity
func move():
	shoot()
	move_horizontal()
	move_gravity()
	move_jump()
	# Add other movement abilities here
	
	# Commit velocities and handle collisions
	velocity = move_and_slide(velocity, Vector2.UP)
	
func instance_bullet():
	var bullet = bullet_prefab.instance()
	bullet_node.add_child(bullet)
	return bullet
	
func shoot():
	if Input.is_action_pressed("shoot") and can_shoot:
		var bullet = instance_bullet()
		can_shoot = false
		bullet_timer.start(0)
		
		
# Walking/air strafe and friction if not walking
func move_horizontal():
	# Can if function into 'if' if different case needed for air
	# Ex: move_horizontal_ground and move_horizontal_air
	var direction = get_walk_direction()
	
	if direction:
		velocity.x = lerp(velocity.x, direction*walk_speed, walk_acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
	
func get_walk_direction():
	var direction : int = 0
	
	if Input.is_action_pressed("walk_right"):
		direction += 1
	if Input.is_action_pressed("walk_left"):
		direction -= 1
	return direction


func move_gravity():
	velocity.y += gravity
	
func move_jump():
	if is_on_floor():
		air_jumps = max_air_jumps
	if Input.is_action_just_pressed("jump") and air_jumps:
		velocity.y = jump_speed
		air_jumps -= 1
