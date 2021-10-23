# part of code taken from KidsCanCode 
# https://kidscancode.org/godot_recipes/2d/platform_character/

extends KinematicBody2D

class_name Player

export var speed : float = 600
export var jump_speed : float = -1000
export var gravity : float = 3000
export var friction : float = 0.1
export var acceleration : float = 0.25

var velocity : Vector2 = Vector2.ZERO
var direction : int = 0

var bullet_prefab : PackedScene = preload("res://Bullets/Bullet.tscn")

func get_input():
	direction = 0
	if Input.is_action_pressed("walk_right"):
		direction += 1
	if Input.is_action_pressed("walk_left"):
		direction -= 1

func set_horizontal_movement():
	if direction != 0:
		velocity.x = lerp(velocity.x, direction * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)

func set_vertical_movement(delta):
	velocity.y += gravity * delta

func set_movement(delta):
	set_horizontal_movement()
	set_vertical_movement(delta)
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	do_jump()

func do_jump():
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_speed

func check_shoot():
	if Input.is_action_pressed("shoot"):
		# if the timer between shots is over
		if $BulletTimer.is_stopped():
			# spawn bullet
			var bullet := bullet_prefab.instance()
			get_tree().current_scene.get_node("Bullets").add_child(bullet)
			# set bullet information
			bullet.position = $BulletExit.global_position
			bullet.direction = direction
			bullet.node_shot_from = self
			# start timer again
			$BulletTimer.start()
			

func _physics_process(delta):
	get_input()
	set_movement(delta)
	check_shoot()
