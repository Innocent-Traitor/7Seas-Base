extends CanvasLayer

@onready var player = get_tree().get_first_node_in_group("player")

@export var goldStar : CompressedTexture2D = load("res://Sprites/star_gold.png")

# Hold vars on our side before moving to the player
var healthLVL = 0


signal purchase(upgrade : String, level : int)

func _ready() -> void:
	connect("purchase", Callable(player, "handle_upgrade_purchase"))

func _on_max_health_button_pressed() -> void:
	if healthLVL < 4:
		healthLVL += 1
		purchase.emit("Max Health", healthLVL)
		var text = ("GridContainer/LeftSide/Max Health/LVL" + str(healthLVL))
		get_node(text).texture = goldStar
