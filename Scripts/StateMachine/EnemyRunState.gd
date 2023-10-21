class_name EnemyRunState
extends State

## This is the exact same as the follow state, 
## it just reverses the values to make it face away and run

@export var actor : Entity

@onready var player = get_tree().get_first_node_in_group("player")

func _ready() -> void:
	set_physics_process(false)
	set_process(false)


func _enter_state() -> void:
	set_physics_process(true)
	set_process(true)


func _exit_state() -> void:
	set_physics_process(false)
	set_process(false)


func _process(_delta) -> void:
	var playerPos = player.global_position
	var lookAngle = (playerPos - actor.global_position).angle() - deg_to_rad(180)
	actor.rotation = lerp_angle(actor.rotation, lookAngle, 0.05)
	
func _physics_process(_delta : float) -> void:
	var playerPos = player.global_position
	var direction = (playerPos - actor.global_position).normalized()
	actor.velocity = (direction * actor.speed * actor.addedSpeed) * -1
	
	actor.move_and_slide()

