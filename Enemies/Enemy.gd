extends KinematicBody2D

class_name Enemy

# todo: animation stuff, just single sprite for now
export var sprite : Resource;

# movement / combat variables
export var health : int = 10
export var damage : int = 1;
export var attack_speed : float = 1.5;
export var move_speed : float = 2;
