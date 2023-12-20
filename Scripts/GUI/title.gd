extends Node2D

@onready var worldScene : PackedScene = preload("res://Scenes/world.tscn")



func _ready() -> void:
	pass

## Updates local player information
func _on_line_edit_text_changed(new_text : String) -> void:
	GlobalLocals.globalLocals["localPlayerName"] = new_text
	var newID = rand_from_seed(len(new_text) * randi())
	GlobalLocals.globalLocals["localEntityID"] = int(str(newID[0]).left(8))


func _on_button_pressed() -> void:
	if not GlobalLocals.globalLocals["localEntityID"] == 0000_0000:
		get_tree().change_scene_to_packed(worldScene)


func _on_line_edit_text_submitted(_new_text : String) -> void:
	_on_button_pressed()
