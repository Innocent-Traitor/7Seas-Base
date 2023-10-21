class_name EnemyAttackState
extends State

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
	var lookAngle = (playerPos - actor.global_position).angle()
	actor.rotation = lerp_angle(actor.rotation, lookAngle, 0.05)

	if not actor.onCooldown:
		#actor.attack()
		actor.onCooldown = true

	
	
func _physics_process(_delta : float) -> void:
	var playerPos = player.global_position
	var direction = (playerPos - actor.global_position).normalized()
	actor.velocity = (direction * actor.speed * actor.addedSpeed)
	actor.move_and_slide()

	


func _on_cooldown_timer_timeout() -> void:
	actor.onCooldown = false
