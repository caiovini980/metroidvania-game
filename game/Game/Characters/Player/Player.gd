class_name Player extends CharacterBase

@export var jump_velocity: float = -400
@export var move_direction: Vector2

func _enter_tree():
	gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	print("Instantiated Player")

func update(delta: float) -> void:
	_handle_input(delta)

func _handle_input(delta: float) -> void:
	# handle movement
	move_direction = Vector2.ZERO
	
	if Input.is_action_pressed("move_left"):
		move_direction.x -= 1
	if Input.is_action_pressed("move_right"):
		move_direction.x += 1
	if Input.is_action_just_pressed("jump"):
		_jump()
		
	# apply direction movement
	position += move_direction.normalized() * walk_speed * delta
	
	# update gravity
	if !is_on_floor():
		velocity.y += gravity * delta
		
	move_and_slide()

func _jump() -> void:
	if is_on_floor():
		velocity.y = jump_velocity
	
