extends CanvasLayer

onready var Item = $Shop/Frame/Item;

var item;

var current = 0;

func _on_TextureButton_pressed():
	get_tree().change_scene("res://Scenes/Level1.tscn")

func set_item(_item):
	Item.texture_normal = _item.sprite;
	Item.texture_normal = _item.sprite;

	item = _item;

func increase_jumps():
	Global.max_player_jumps += 1;

func allow_glide():
	Global.can_glide = true;

func buy_upgrade():
	if(item.name == "2xjump"):
		Global.max_player_jumps = 2;
	elif(item.name == "3xjump"):
		Global.max_player_jumps = 3;
	elif(item.name == "4xjump"):
		Global.max_player_jumps = 4;
	elif(item.name == "upgradedjump"):
		Global.upgraded_jump = true;
	elif(item.name == "glide"):
		Global.can_glide = true;
	
	Global.remaining_upgrades.erase(item);
	item = null;
	Item.texture_normal = null;

func _on_BackButton_pressed():
	if(Global.remaining_upgrades.size() == 0):
		return;
	
	current -= 1;
	if current < 0:
		current = Global.remaining_upgrades.size() - 1;
	print(current);
	set_item(Global.remaining_upgrades[current]);

func _on_ForwardButton_pressed():
	if(Global.remaining_upgrades.size() == 0):
		return;
	
	current += 1;
	if current > Global.remaining_upgrades.size() - 1:
		current = 0;
	print(current);
	set_item(Global.remaining_upgrades[current]);


func _on_Item_pressed():
	if item == null:
		return;
	buy_upgrade();
