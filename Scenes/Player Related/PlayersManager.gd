extends Node2D

@onready var PlayerBody : PackedScene = preload("res://Scenes/Player Related/player.tscn")

signal player_spawned(node)

func _ready() -> void:
	var xPos = randi_range(200, 1500)
	var yPos = randi_range(200, 800)
	var newPlayer = PlayerBody.instantiate()
	newPlayer.position = Vector2(xPos, yPos)
	add_child(newPlayer)
	print("Spawned Player")
	


