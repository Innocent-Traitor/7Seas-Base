extends Entity

#@export var PlayerCamera : Camera2D

@onready var PlayerCamera : Camera2D = get_node("%PlayerCamera")
@onready var LeftCannon : Marker2D = get_node("%LeftCannon")
@onready var RightCannon : Marker2D = get_node("%RightCannon")
@onready var FrontCannon : Marker2D = get_node("%FrontCannon")

signal player_attack(pos : Vector2, dir : Vector2, damage : int, attacker: String)
signal player_hit(health : float)

##### FUNCTIONS #####

func _ready():
	player_hit.emit(health)
	connect("fire_cannonball", Callable(gameManager, "create_cannonball_attack"))

func _process(_delta):
	# Look towards the mouse and lerp it
	var mousePos = get_global_mouse_position()
	var mouseAngle = (mousePos - global_position).angle()
	rotation = lerp_angle(rotation, mouseAngle, 0.05)

	PlayerCamera.global_position = position


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Fire") and not onCooldown:
		print("Trying to fire cannonball")
		var direction = ((get_global_mouse_position() - position).normalized()).rotated(deg_to_rad(randf_range(-5, 5)))
		fire_cannonball.emit(FrontCannon.global_position, direction, damage, "Player")
		#attack(FrontCannon.global_position, direction, damage, "Player")
		onCooldown = true
		$CooldownTimer.start()


		# Maybe come back to this? Just with a small amount of testing,
		# It doesn't seem very fun and difficult to use
	# if event.is_action_pressed("LeftFire") and not onCooldown:
	# 	var direction = ((get_global_mouse_position() - position).normalized()).rotated(deg_to_rad(randf_range(-70, -80)))
	# 	player_attack.emit(LeftCannon.global_position, direction, damage, "Player")
	# 	onCooldown = true
	# 	$CooldownTimer.start()

	# if event.is_action_pressed("RightFire") and not onCooldown:
	# 	var direction = ((get_global_mouse_position() - position).normalized()).rotated(deg_to_rad(randf_range(70, 80)))
	# 	player_attack.emit(RightCannon.global_position, direction, damage, "Player")
	# 	onCooldown = true
	# 	$CooldownTimer.start()

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


func _on_cooldow_timer_timeout():
	onCooldown = false
