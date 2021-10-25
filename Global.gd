extends Node

var max_player_jumps : int = 1;
var upgraded_jump : bool = false;
var can_glide : bool = false;
var remaining_upgrades = [
	{
		"name": "2xjump",
		"sprite": preload("res://Textures/Shop/Icon_DoubleJump.png")
	},
	{
		"name": "upgradedjump",
		"sprite": preload("res://Textures/Shop/Upgrade_Jump_Icon.png")
	},
	{
		"name": "3xjump",
		"sprite": preload("res://Textures/Shop/Icon_Triple.png")
	},
	{
		"name": "4xjump",
		"sprite": preload("res://Textures/Shop/Icon_QuadJump.png")
	},
	{
		"name": "glide",
		"sprite": preload("res://Textures/Shop/Icon_Glide.png")
	}
]
