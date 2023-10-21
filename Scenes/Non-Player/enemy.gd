extends Entity



func _ready() -> void:
	speed = 100

# func attack() -> void:
# 	var target = get_tree().get_first_node_in_group("player")
# 	var direction = ((target.global_position - position).normalized()).rotated(deg_to_rad(randf_range(-5, 5)))
# 	fire_cannonball.emit($Marker2D.global_position, direction, damage, "Enemy")


# Wandering - Wanders around, not firing and just moving around the map
# Running - Actively runs away from other ships
# Attacking - Will attack other ships


