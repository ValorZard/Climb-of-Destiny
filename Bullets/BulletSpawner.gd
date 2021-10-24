extends Node2D

class_name BulletSpawner

export var angle : int
export var speed : int

var bullet_prefab = preload("res://Bullets/Bullet.tscn")

# Node that all bullets are made children of
onready var bullet_node: Node = get_tree().get_current_scene().get_node("Bullets")
# Must be onready to allow export vars to load
onready var bullet_velocity : Vector2 = Vector2(speed*cos(deg2rad(angle)), -speed*sin(deg2rad(angle)))

func instance_bullet():
	var bullet = bullet_prefab.instance()
	bullet_node.add_child(bullet)
	return bullet

func set_bullet_position(bullet):
	var target_position = self.get_global_position()
	bullet.set_position(target_position)
	
func shoot():
	var bullet = instance_bullet()
	bullet.set_position(self.get_global_position())
	bullet.set_velocity(bullet_velocity)
