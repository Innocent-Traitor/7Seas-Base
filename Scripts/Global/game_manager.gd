extends Node2D

@onready var CannonBall : PackedScene = preload("res://Scenes/Entities/cannonball.tscn") ## entities/cannonball.tscn


## I imagine when making this into Multiplayer, I'll have to
## have a local and a global game_manager, one for tracking
## local player GUI, drawing, etc, and the other to track
## stuff between all players. Dunno yet. Sucks to suck

# func _on_player_attack(pos : Vector2, dir : Vector2, damage : int, attacker: String):
# 	create_cannonball_attack(pos, dir, damage, attacker)

func _ready() -> void:
	pass

func create_cannonball_attack(pos : Vector2, dir : Vector2, attackRange : float, damage : int, attacker: String):
	var cannonballAttack = CannonBall.instantiate()
	cannonballAttack.position = pos
	cannonballAttack.direction = dir
	cannonballAttack.attackRange = attackRange
	cannonballAttack.damage = damage
	cannonballAttack.attacker = attacker
	print("Created Cannonball")
	
	$Projectiles.add_child(cannonballAttack)


