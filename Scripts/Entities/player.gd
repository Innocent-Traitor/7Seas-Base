extends Entity

#@export var PlayerCamera : Camera2D

@onready var PlayerCamera : Camera2D = get_node("%PlayerCamera")
@onready var LeftCannon : Marker2D = get_node("%LeftCannon")
@onready var RightCannon : Marker2D = get_node("%RightCannon")
@onready var FrontCannon : Marker2D = get_node("%FrontCannon")

@onready var gui = get_tree().get_first_node_in_group("gui")
@onready var buyMenu = get_tree().get_first_node_in_group("buyMenu")

var shopping  : bool = false ## Is the player shopping?
var coins : int = 99999999 ## How many coins does the player have?

## I don't believe this signal is used anymore? Should've been replaced with "fire_cannonball" in the entity class
signal player_attack(pos : Vector2, dir : Vector2, range : float, damage : int, attacker: String)
signal player_hit(health : float) ## Used to communicate to the GUI to show proper health

##### FUNCTIONS #####

func _ready():
	connect("fire_cannonball", Callable(gameManager, "create_cannonball_attack"))
	connect("fire_cannonball", Callable(gui, "_on_player_attack"))
	connect("player_hit", Callable(gui, "_on_player_hit"))
	player_hit.emit(health)

func _process(_delta):
	# Look towards the mouse and lerp it
	var mousePos = get_global_mouse_position()
	var mouseAngle = (mousePos - global_position).angle()
	rotation = lerp_angle(rotation, mouseAngle, 0.05)

	PlayerCamera.global_position = position


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Fire") and not onCooldown:
		handle_cannon_fire()

	if event.is_action_pressed("Buy"):
		if shopping:
			buyMenu.visible = false
			shopping = false
		else:
			buyMenu.visible = true
			shopping = true
	
	if event.is_action_pressed("Print"):
		print(healthMax)
		print(attackRange)
		print(damage)
		print(addedSpeed)
		print(firingSpeed)
		print(cannons)

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
	velocity = velocity.lerp(direction * speed * addedSpeed, 0.1)

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

func handle_upgrade_purchase(upgrade : String, level : int) -> void:
	if can_purchase(upgrade):
		match upgrade:
			"Max Health":
				healthMaxLVL = level
				coins -= 10
			"Range":
				attackRangeLVL = level
				coins -= 10
			"Damage":
				damageLVL = level
				coins -= 10
			"Ship Speed":
				addedSpeedLVL = level
				coins -= 10
			"Firing Speed":
				firingSpeedLVL = level
				coins -= 10
			"Cannon":
				cannonsLVL = level
				coins -= 30
		

		update_stats()

## Checks to make sure they have coins to buy the upgrade
## Cannons = 30, all other upgrades = 10
func can_purchase(upgrade) -> bool:
	if upgrade == "cannons":
		if coins <= 30:
			return false
		else:
			return true
	else:
		if coins <= 10:
			return false
		else:
			return true

## Handle cannon firing logic
func handle_cannon_fire() -> void:
	# Get firing force and direction
	var firingForce = (get_global_mouse_position() - position) * attackRange
	var direction = firingForce.normalized().rotated(deg_to_rad(randf_range(-5, 5)))

	# Fire the first cannon ball, and see if we can fire the other two
	fire_cannonball.emit(FrontCannon.global_position, direction, attackRange, damage, entityName)

	if cannons >= 2:
		var leftDir = direction.rotated(deg_to_rad(randf_range(-30, -20)))
		fire_cannonball.emit(FrontCannon.global_position, leftDir, attackRange, damage, "Player")
	
	if cannons == 3:
		var rightDir = direction.rotated(deg_to_rad(randf_range(30, 20)))
		fire_cannonball.emit(FrontCannon.global_position, rightDir, attackRange, damage, "Player")

	onCooldown = true
	$CooldownTimer.start()
	
	