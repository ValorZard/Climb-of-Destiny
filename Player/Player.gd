# part of code taken from KidsCanCode 
# https://kidscancode.org/godot_recipes/2d/platform_character/

extends KinematicBody2D

class_name Player

export var speed : float = 600
export var jump_speed : float = -2000
export var gravity : float = 70
export var friction : float = 0.1
export var acceleration : float = 0.25

export var max_air_jumps : int = 1
var air_jumps : int = max_air_jumps
var is_jumping : bool = false

var velocity : Vector2 = Vector2.ZERO
var direction : int = 0
var facing_right := true

var bullet_prefab : PackedScene = preload("res://Bullets/Bullet.tscn")

func get_input():
	direction = 0
	if Input.is_action_pressed("walk_right"):
		direction += 1
	if Input.is_action_pressed("walk_left"):
		direction -= 1
	
	# check if the facing direction is same as mouse
	facing_right = get_viewport().get_mouse_position().x - self.position.x >= 0
		

func set_horizontal_movement():
	if direction != 0:
		velocity.x = lerp(velocity.x, direction * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)

func set_vertical_movement(delta):
	# when on floor and jump is not buffered, there shouldn't be any y velocity
	# if jump is buffered, y velocity should equal jump speed
	# if is in air, the player should be affected by gravity
	if is_on_floor() and !is_jumping:
		velocity.y = 0
		# refill air jumps now that we've landed
		air_jumps = max_air_jumps
	elif is_on_floor():
		is_jumping = false
	else:
		velocity.y += gravity

func set_movement(delta):
	set_horizontal_movement()
	set_vertical_movement(delta)
	do_jump()
	
	velocity = move_and_slide(velocity, Vector2.UP)

func do_jump():
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_speed
		elif air_jumps > 0:
			velocity.y = jump_speed
			air_jumps -= 1

func set_bullet_exit():
	# flip position of bullet exit based on facing direction
	if facing_right and $BulletExit.position.x < 0:
		$BulletExit.position.x = -$BulletExit.position.x
	elif !facing_right and $BulletExit.position.x > 0:
		$BulletExit.position.x = -$BulletExit.position.x

func check_shoot():
	if Input.is_action_pressed("shoot"):
		# if the timer between shots is over
		if $BulletTimer.is_stopped():
			# spawn bullet
			var bullet := bullet_prefab.instance()
			get_tree().current_scene.get_node("Bullets").add_child(bullet)
			# set bullet information
			bullet.position = $BulletExit.global_position
			bullet.facing_right = facing_right
			bullet.node_shot_from = self
			# start timer again
			$BulletTimer.start()
			

func _physics_process(delta):
	get_input()
	set_movement(delta)
	set_bullet_exit()
	check_shoot()
	print_player()

func print_player():
	var print_string := ""
	print_string += "Direction: " + str(direction) + "\n"
	$Label.text = print_string
