extends RigidBody2D

@export var speed : int = 100

var direction = Vector2.UP
var damage : int
var attacker : String
var attackRange : float

func _ready() -> void:
	linear_velocity += direction * speed

	var tween = create_tween()
	var tweenDuration = (1.5 * attackRange)
	tween.tween_interval(tweenDuration)
	tween.tween_property(self, "scale", Vector2(0.5, 0.5), 1) # .set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.tween_callback(self.queue_free)
	tween.play()