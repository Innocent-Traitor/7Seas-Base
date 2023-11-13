extends Node2D

@onready var EnemyBody : PackedScene = preload("res://Scenes/Entities/enemy.tscn") 



func _on_spawn_timer_timeout() -> void:
	for i in 10:
		var xPos = randi_range(200, 1500)
		var yPos = randi_range(200, 800)
		var stats = randomize_stats()
		var newEnemy = EnemyBody.instantiate()

		newEnemy.position = Vector2(xPos, yPos)
		newEnemy.healthMaxLVL = stats[0]
		newEnemy.attackRangeLVL = stats[1]
		newEnemy.damageLVL = stats[2]
		newEnemy.addedSpeedLVL = stats[3]
		newEnemy.firingSpeedLVL = stats[4]
		newEnemy.cannonsLVL = stats[5]

		add_child(newEnemy)
		print("New Enemy Placed at: " + str(xPos) + str(yPos))
		print("Enemy stats: " + str(stats))

## Get random stats for an AI. Returns an array in the following order:
## [Max Health, Range, Damage, Ship Speed, Firing Speed, Cannons]
func randomize_stats() -> Array:
	var returnValue = []
	# Handles Max Health, Range, Damage, Ship Speed, and Firing Speed
	for i in 5:
		var ran = random_weighted([45, 25, 15, 10, 5])
		returnValue.append(ran)

	# Cannon Upgrade
	var ran = random_weighted([60, 30, 10])
	returnValue.append(ran)
	
	# Finally return the array
	return returnValue

## Returns an index based on the args provided using the sum to provided a weighted probability
## Example input: ([1, 2, 3]), could return: 0 (1/6 of the time), 1 (1/3 of the time), 2 (1/2 of the time)
func random_weighted(params : Array) -> int:
	var sum = 0
	for i in params:
		sum += i
	var rnd = randi_range(0, sum)
	for i in params:
		if (rnd <= i):
			return params.find(i, 0)
		rnd -= i
	print_debug("COULD NOT GENERATE WEIGHTED RANDOM NUMBER, RETURNING 0")
	print(str(params))
	return 0
	
	


