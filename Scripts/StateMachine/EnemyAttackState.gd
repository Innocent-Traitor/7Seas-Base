class_name EnemyAttackState
extends State

@export var actor : Entity

var target : Object
var target_list : Array = []

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
	if target == null:
		return

	var targetPos = target.global_position
	var lookAngle = (targetPos - actor.global_position).angle()
	actor.rotation = lerp_angle(actor.rotation, lookAngle, 0.05)

	if not actor.onCooldown:
		actor.attack(target)
		actor.onCooldown = true
		$CooldownTimer.start()

	
	
func _physics_process(_delta : float) -> void:
	if target == null:
		return
	var targetPos = target.global_position
	var direction = (targetPos - actor.global_position).normalized()
	actor.velocity = (direction * actor.speed * actor.addedSpeed)
	actor.move_and_slide()

	


func _on_cooldown_timer_timeout() -> void:
	actor.onCooldown = false


func _on_target_timer_timeout() -> void:
	target = find_target()
	if target == null:
		$TargetTimer.start()


func _on_vision_body_exited(body : Node2D) -> void:
	if target_list.has(body):
		target_list.erase(body)


func _on_vision_body_entered(body : Node2D) -> void:
	if not target_list.has(body):
		target_list.append(body)

func find_target() -> Object:
	if target_list.size() > 0:
		return target_list.pick_random()
	else:
		return null
