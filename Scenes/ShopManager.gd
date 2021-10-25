extends CanvasLayer

onready var Item = $Shop/Frame/Item;

var current = 0;

func _on_TextureButton_pressed():
	get_tree().change_scene("res://Scenes/Shop.tscn")



func set_item(item):
	Item.texture_normal = item.sprite;
	Item.texture_normal = item.sprite;

func increase_jumps():
	Global.max_player_jumps += 1;

func allow_glide():
	Global.can_glide = true;


func _on_BackButton_pressed():
	current -= 1;
	if current < 0:
		current = Global.remaining_upgrades.size() - 1;

func _on_ForwardButton_pressed():
	current += 1;
	if current > Global.remaining_upgraded.size() - 1;
		current = 0;
