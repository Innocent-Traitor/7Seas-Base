extends Node2D

@onready var EnemyBody : PackedScene = preload("res://Scenes/enemy.tscn")



func _on_spawn_timer_timeout() -> void:
	var xPos = randi_range(200, 1500)
	var yPos = randi_range(200, 800)
	var newEnemy = EnemyBody.instantiate()
	newEnemy.position = Vector2(xPos, yPos)
	add_child(newEnemy)
	print("New Enemy Placed at: " + str(xPos) + str(yPos))
	


