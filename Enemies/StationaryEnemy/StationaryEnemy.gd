# StationaryEnemies sit in one area and attack the player with a long windup when in range

extends Enemy

class_name StationaryEnemy

# references
onready var AnimationPlayer = $AnimationPlayer;

# start attack anim when player enters radius
func _on_AttackRadius_body_entered(body):
	if body is Player:
		AnimationPlayer.play("Attack");

# damage player if they collide with head hitbox
# hitbox is enabled/disabled in the Attack animation 
func _on_HeadHitbox_body_entered(body):
	if body is Player:
		print("Player hit! but player health isn't set up yet. TODO");

func play_idle_animation():
	AnimationPlayer.play("Idle");
