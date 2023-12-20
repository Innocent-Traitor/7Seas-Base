extends Node2D
### This handles local player instancing and communication between the global game manager.
### NOTE: This is ONLY used locally, and cannot communciate between multiple clients!!!

@onready var PlayerBody : PackedScene = preload("res://Scenes/Entities/player.tscn") ## entities/player.tscn

signal player_spawned(node)

func _ready() -> void:
	var xPos = randi_range(200, 1500)
	var yPos = randi_range(200, 800)
	var newPlayer = PlayerBody.instantiate()
	newPlayer.position = Vector2(xPos, yPos)
	newPlayer.entityName = GlobalLocals.globalLocals["localPlayerName"]
	newPlayer.entityID = GlobalLocals.globalLocals["localEntityID"]
	add_child(newPlayer)
	#emit_signal("player_spawned", newPlayer)
	print("Spawned Player")
	


