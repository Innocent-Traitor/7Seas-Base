extends CanvasLayer

@onready var HealthBar = get_node("%HealthBar")
@onready var CooldownBar = get_node("%CooldownBar")



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_player_health(100)
	CooldownBar.scale.x = 0

func update_player_health(value : float) -> void:
	value /= 100
	if value <= 0:
		$HealthBar.scale = Vector2.ZERO
		return
	$HealthBar.scale.x = 0.3 * value

func _on_player_hit(value : float) -> void:
	update_player_health(value)


func _on_player_attack(_a, _b, _c, _d) -> void:
	CooldownBar.scale.x = 0.3
	var tween = create_tween()
	tween.tween_property(CooldownBar, "scale", Vector2(0.0, 0.15), 1)
	tween.play()


