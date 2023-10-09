extends Node2D

@onready var CannonBall : PackedScene = preload("res://Scenes/Player Related/cannonball.tscn")


func _on_player_attack(pos : Vector2, dir : Vector2, damage : int, attacker: String):
	create_cannonball_attack(pos, dir, damage, attacker)

func create_cannonball_attack(pos : Vector2, dir : Vector2, damage : int, attacker: String):
	var cannonballAttack = CannonBall.instantiate()
	cannonballAttack.position = pos
	cannonballAttack.direction = dir
	cannonballAttack.damage = damage * 10
	cannonballAttack.attacker = attacker
	
	$Projectiles.add_child(cannonballAttack)
