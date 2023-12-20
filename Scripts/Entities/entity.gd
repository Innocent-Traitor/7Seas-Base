extends CharacterBody2D
class_name Entity

@export_category("Movement")
@export var speed : float = 250 ## Base Speed of the ship.

@onready var gameManager = get_tree().get_first_node_in_group("game_manager")


# Base Variables
var onCooldown : bool = false
var health : float = 100
var entityName : String = "Unknown"
var entityID : int = 0000_0000

# Upgrade Levels
var healthMaxLVL : int = 0 		## 100, 200, 300, 400, 500   | Max Health
var attackRangeLVL : int = 0 	## 1, 1.1, 1.2, 1.3, 1.4     | Multipled to the cannonball tween interval
var damageLVL : int = 0			## 10, 15, 20, 25, 30        | Each one does +10 damage
var addedSpeedLVL : int = 0		## 1, 1.1, 1.2, 1.3, 1.4     | Each one moves the ship 10% faster
var firingSpeedLVL : int = 0  ## 1, 0.95, 0.9, 0.85, 0.8   | How much the firing cooldown is multipled by
var cannonsLVL : int = 0		## 1, 2, 3                   | How many cannons the ship has

# Upgrades 
var healthMax : int = UpgradesDb.UPGRADES["maxHealth"][healthMaxLVL]
var attackRange : float = UpgradesDb.UPGRADES["attackRange"][attackRangeLVL]  
var damage : int = UpgradesDb.UPGRADES["damage"][damageLVL]     
var addedSpeed : float = UpgradesDb.UPGRADES["addedSpeed"][addedSpeedLVL]
var firingSpeed : float = UpgradesDb.UPGRADES["firingSpeed"][firingSpeedLVL]    
var cannons : int = UpgradesDb.UPGRADES["cannons"][cannonsLVL]       

## Signal sent to the game manager to create the cannonball
signal fire_cannonball(pos : Vector2, dir : Vector2, range : float, damage : int, attacker: String)

func _ready() -> void:
	connect("fire_cannonball", Callable(gameManager, "create_cannonball_attack"))
	$CooldownTimer.wait_time = firingSpeed
	

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

## Updates all upgrades according to the UpgradesGB.gd,
## also updates the firingSpeed CooldownTimer
func update_stats() -> void:
	healthMax  = UpgradesDb.UPGRADES["maxHealth"][healthMaxLVL]
	attackRange  = UpgradesDb.UPGRADES["attackRange"][attackRangeLVL]  
	damage = UpgradesDb.UPGRADES["damage"][damageLVL]     
	addedSpeed = UpgradesDb.UPGRADES["addedSpeed"][addedSpeedLVL]
	firingSpeed = UpgradesDb.UPGRADES["firingSpeed"][firingSpeedLVL]
	cannons = UpgradesDb.UPGRADES["cannons"][cannonsLVL] 

	$CooldownTimer.wait_time = firingSpeed
