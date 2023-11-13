extends State
class_name EnemyLoboState
## State: Turns the AI into an unmoving entity

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
	pass
	
func _physics_process(_delta : float) -> void:
	pass