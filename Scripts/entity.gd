extends CharacterBody2D
class_name Entity

@export_category("Movement")
@export var speed : float = 250 ## Base Speed of the ship.

@onready var gameManager = get_tree().get_first_node_in_group("game_manager")


# Base Variables
var onCooldown : bool = false
var health : float = 100

# Upgrades | Export or change these into arrays?
# Can potentially make it easier when upgrading by just incrementing one?
var healthMax : int = 100   ## 100, 200, 300, 400, 500   | Max Health
var attackRange : int = 5   ## 5, 4, 3, 2, 1             | Lower = More Range
var damage : int = 1        ## 1, 2, 3, 4, 5             | Each one does +10 damage
var addedSpeed : float = 1  ## 1, 1.1, 1.2, 1.3, 1.4     | Each one moves the ship 10% faster
var cannons : int = 1       ## 1, 2, 3                   | How many cannons the ship has

signal fire_cannonball(pos : Vector2, dir : Vector2, damage : int, attacker: String)

func _ready() -> void:
	connect("fire_cannonball", Callable(gameManager, "create_cannonball_attack"))

func _on_hitbox_body_entered(body : Node2D) -> void:
	if body.is_in_group("Projectiles"):
		var damageTaken = body.damage
		var attacker = body.attacker

		health -= damageTaken
		body.queue_free()
		print("I'm hit! Health: " + str(health) + " Attacker: " + str(attacker))
	
	if health <= 0:
		print("Down we go!")
		queue_free()

func _on_cooldown_timer_timeout() -> void:
	onCooldown = false

func attack(pos : Vector2, dir : Vector2, dam : int, attacker: String) -> void:
	emit_signal("fire_cannonball", pos, dir, dam, attacker)
