class_name EnemyWanderState
extends State

@export var actor : Entity

@onready var player = get_tree().get_first_node_in_group("player")

@export var wanderRadius : float = 50.0 ## Radius of the wandering circle
@export var wanderDistance : float = 100.0
@export var wanderAngle : float = 0.0
@export var wanderAngleChange : float = 5



func _ready() -> void:
	set_physics_process(false)
	set_process(false)


func _enter_state() -> void:
	set_physics_process(true)
	set_process(true)


func _exit_state() -> void:
	set_physics_process(false)
	set_process(false)

func _physics_process(_delta: float) -> void:
	#wanderAngle += randf_range(-wanderAngleChange, wanderAngleChange)
	#var wanderCenter = actor.velocity.normalized() * wanderDistance
	#var displacement = Vector2(1, 0).rotated(wanderAngle) * wanderRadius
	#var wanderForce = wanderCenter + displacement
	#actor.velocity = wanderForce.normalized() * actor.speed
	actor.move_and_slide()


func _process(_delta: float) -> void:
	var lookAngle = atan2(actor.velocity.y, actor.velocity.x)
	actor.rotation = lerp_angle(actor.rotation, lookAngle, 0.05)


func _on_timer_timeout() -> void:
	wanderAngle += randf_range(-wanderAngleChange, wanderAngleChange)
	var wanderCenter = actor.velocity.normalized() * wanderDistance
	var displacement = Vector2(1, 0).rotated(wanderAngle) * wanderRadius
	var wanderForce = wanderCenter + displacement
	actor.velocity = wanderForce.normalized() * actor.speed

	$Timer.set_wait_time(randf_range(0.1 , 0.3))
