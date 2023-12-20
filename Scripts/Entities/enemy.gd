extends Entity



func _ready() -> void:
	speed = 100
	$NamePlate.text = entityName
	connect("fire_cannonball", Callable(gameManager, "create_cannonball_attack"))

func attack(target : Object) -> void:
	var direction = ((target.global_position - position).normalized()).rotated(deg_to_rad(randf_range(-5, 5)))
	fire_cannonball.emit($Marker2D.global_position, direction, attackRange, damage, entityName)


# Wandering - Wanders around, not firing and just moving around the map
# Running - Actively runs away from other ships
# Attacking - Will attack other ships
# Follow - Follows the player
# Lobo - Does not move the enemy


