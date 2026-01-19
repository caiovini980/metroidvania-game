extends Node
class_name MovementComponent

# ------------ SIGNALS ------------ 
signal on_jump_pressed

# ------------ PUBLIC VARIABLES ------------ 
@export var jump_force: float
@export var walk_speed: float

# ------------ PRIVATE VARIABLES ------------ 
var _is_on_ground: bool = false
var _normal_speed: float

# ------------ NATIVE FUNCTIONS ------------ 
func _ready():
	_normal_speed = walk_speed

# ------------ PUBLIC FUNCTIONS ------------ 
func move(direction: Vector2) -> void:
	owner.position += direction * (walk_speed * 10)

func jump() -> void:
	_is_on_ground = false
	on_jump_pressed.emit(-jump_force * 10)

func is_touching_the_ground() -> bool:
	return _is_on_ground

func get_jump_force() -> float:
	return jump_force * 10

func stop() -> void:
	walk_speed = 0
	
func reset_walk_speed() -> void:
	walk_speed = _normal_speed

# ------------ SIGNAL SUBSCRIPTIONS ------------ 
func _on_player_on_landed():
	_is_on_ground = true
