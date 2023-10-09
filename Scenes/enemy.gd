extends Entity

#signal enemy_attack(pos : Vector2, dir : Vector2, damage : int, attacker: String)


func _ready() -> void:
	speed = 100


# Wandering - Wanders around, not firing and just moving around the map
# Running - Actively runs away from other ships
# Attacking - Will attack other ships


