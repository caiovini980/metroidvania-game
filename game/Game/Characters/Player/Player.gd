class_name Player extends CharacterBase

@export_group("Control Variables")
@export var jump_force: float

@export_group("Animation")
@export var animation_player: AnimationPlayer
@export var animated_sprite: AnimatedSprite2D

@export_group("Particles")
@export var step_particles: GPUParticles2D

@export_group("Audio")
@export var audio_player: AudioStreamPlayer2D
@export var steps_sfx: Array[AudioStream]

var last_faced_direction: Vector2 = Vector2.ZERO
var has_jumped: bool = false
var move_direction: Vector2

func _enter_tree():
	gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	
	if animation_player == null:
		animation_player = $AnimationPlayer
		
	if animated_sprite == null:
		animated_sprite = $Sprite
		
	if step_particles == null:
		step_particles = $StepParticles
	
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
	
	animated_sprite.flip_h = last_faced_direction.x > 0
	
	# only apply movement when needed
	if move_direction.length() > 0:
		last_faced_direction = move_direction
		position += move_direction.normalized() * walk_speed * delta
	
	# update gravity
	if !is_on_floor():
		velocity.y += gravity * delta
	
	handle_animations()
	move_and_slide()

func handle_animations() -> void:
	if !is_on_floor():
		if velocity.y > 0 and !has_jumped:
			animation_player.play("falling")
		else:
			animation_player.play("jump")
	else:
		has_jumped = false
		
		if move_direction.length() > 0:
			animation_player.play("walk")
		else:
			animation_player.play("idle")

func on_step() -> void:
	step_particles.restart()
	step_particles.emitting = true
	audio_player.stream = steps_sfx[randi_range(0, steps_sfx.size() - 1)]
	audio_player.play()

func _jump() -> void:
	if is_on_floor():
		velocity.y = jump_force
		has_jumped = true
	
