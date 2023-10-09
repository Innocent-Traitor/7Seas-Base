extends RigidBody2D

@export var speed : int = 100

var direction = Vector2.UP
var damage : int
var attacker : String

func _ready() -> void:
	linear_velocity += direction * speed

	var tween = create_tween()
	tween.tween_interval(1.5)
	tween.tween_property(self, "scale", Vector2(0.5, 0.5), 1) # .set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.tween_callback(self.queue_free)
	tween.play()


func _process(_delta: float) -> void:
	pass
