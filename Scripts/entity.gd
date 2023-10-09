extends CharacterBody2D
class_name Entity

@export_category("Movement")
@export var speed : float = 250 ## Base Speed of the ship.


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
