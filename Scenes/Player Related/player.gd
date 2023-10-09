extends Entity


@onready var PlayerCamera : Camera2D = get_node("%PlayerCamera")

signal player_attack(pos : Vector2, dir : Vector2, damage : int, attacker: String)

##### FUNCTIONS #####

func _process(_delta):
	# Look towards the mouse and lerp it
	var mousePos = get_global_mouse_position()
	var mouseAngle = (mousePos - global_position).angle()
	rotation = lerp_angle(rotation, mouseAngle, 0.05)

	PlayerCamera.global_position = position

	# Firing Input | Potentially move this into an unhandled input
	# TODO: Research unhandled input vs _process input handling
	if Input.is_action_just_pressed("Fire") and !onCooldown:
		player_attack.emit($Marker2D.global_position, (get_global_mouse_position() - position).normalized(), damage, "Player")
		onCooldown = true
		$CooldownTimer.start()


func _physics_process(_delta: float) -> void:
	var mousePos = get_global_mouse_position()
	var direction = (mousePos - global_position).normalized()
	velocity = (direction * speed * addedSpeed)

	# Varied speed based on distance from mouse
	# I fucking hope I find a better way to do this
	if (position - mousePos).length() < 400:
		velocity *= 1
	if (position - mousePos).length() < 200:
		velocity *= 0.66
	if (position - mousePos).length() < 75:
		velocity *= 0.33
	
	move_and_slide()
