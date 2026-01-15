extends Node
class_name MovementComponent

# ------------ SIGNALS ------------ 
signal on_jump_pressed

# ------------ PUBLIC VARIABLES ------------ 
@export var jump_force: float
@export var walk_speed: float

# ------------ PRIVATE VARIABLES ------------ 
var _move_direction: Vector2
var _last_faced_direction: Vector2 = Vector2.ZERO
var _is_on_ground: bool = false

# ------------ NATIVE FUNCTIONS ------------ 

# ------------ PUBLIC FUNCTIONS ------------ 
func handle_movement(delta: float) -> void:
	_move_direction = Vector2.ZERO
	
	if Input.is_action_pressed("move_left"):
		_move_direction.x -= 1
	if Input.is_action_pressed("move_right"):
		_move_direction.x += 1
	if Input.is_action_just_pressed("jump"):
		_is_on_ground = false
		on_jump_pressed.emit()
	
	# only apply movement when needed
	if _move_direction.length() > 0:
		_last_faced_direction = _move_direction
		owner.position += _move_direction.normalized() * walk_speed * delta
		
func is_touching_the_ground() -> bool:
	return _is_on_ground

func get_jump_force() -> float:
	return jump_force

func get_move_direction() -> Vector2:
	return _move_direction

func is_facing_right() -> bool:
	return _last_faced_direction.x > 0

# ------------ SIGNAL SUBSCRIPTIONS ------------ 
func _on_player_on_landed():
	_is_on_ground = true
