extends CanvasLayer

@onready var player = get_tree().get_first_node_in_group("player")

@export var goldStar : CompressedTexture2D = load("res://Sprites/star_gold.png")

# Hold vars on our side before moving to the player
var healthLVL = 0
var rangeLVL = 0
var damageLVL = 0


signal purchase(upgrade : String, level : int)

func _ready() -> void:
	connect("purchase", Callable(player, "handle_upgrade_purchase"))

func _on_max_health_button_pressed() -> void:
	if healthLVL < 4 and player.can_purchase("health"):
		healthLVL += 1
		purchase.emit("Max Health", healthLVL)
		var text = ("GridContainer/LeftSide/Max Health/LVL" + str(healthLVL))
		get_node(text).texture = goldStar


func _on_range_button_pressed() -> void:
	if rangeLVL < 4 and player.can_purchase("range"):
		rangeLVL += 1
		purchase.emit("Range", rangeLVL)
		var text = ("GridContainer/LeftSide/Range/LVL" + str(rangeLVL))
		get_node(text).texture = goldStar


func _on_damage_button_pressed() -> void:
	if damageLVL < 4 and player.can_purchase("damage"):
		damageLVL += 1
		purchase.emit("Damage", damageLVL)
		var text = ("GridContainer/LeftSide/Damage/LVL" + str(damageLVL))
		get_node(text).texture = goldStar
