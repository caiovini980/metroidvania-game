class_name Player 
extends CharacterBody2D

# ------------ SIGNALS ------------ 
signal on_landed

# ------------ PUBLIC VARIABLES ------------ 
@export_group("Animation")
@export var animation_player: AnimationPlayer
@export var animation_tree: AnimationTree
@export var animated_sprite: AnimatedSprite2D

@export_group("Particles")
@export var step_particles: GPUParticles2D

@export_group("Components")
@export var movement_component: MovementComponent
@export var hitbox_component: HitboxComponent
@export var step_sound_emitter_component: SoundEmitterComponent
@export var jump_sound_component: SoundEmitterComponent

# ------------ PRIVATE VARIABLES ------------ 
var _jump_audio: AudioStream
var _is_on_air: bool = false
var _can_animate: bool = true
var _is_attacking: bool = false
var _direction: Vector2
var _last_faced_direction: Vector2 = Vector2.RIGHT

# ------------ NATIVE FUNCTIONS ------------ 
func _ready() -> void:
	if animation_player == null:
		animation_player = $AnimationPlayer
		
	if animation_tree == null:
		animation_tree = $AnimationTree
		
	if animated_sprite == null:
		animated_sprite = $Sprite
		
	if step_particles == null:
		step_particles = $StepParticles
		
	if movement_component == null:
		movement_component = $MovementComponent
		
	if step_sound_emitter_component == null:
		step_sound_emitter_component = $StepSoundEmitter
		
	if jump_sound_component == null:
		jump_sound_component = $JumpSoundEmitter
		
	if hitbox_component == null:
		hitbox_component = $AttackHitArea
		
	# setup jump sound correctly
	var _jump_audio_player: AudioStreamPlayer2D = jump_sound_component.audio_player
	_jump_audio_player.volume_db = -10
	_jump_audio = jump_sound_component.get_audio_at(0)
	
	# setup colliders
	hitbox_component.set_collider_visibility(false)
	
	print("Instantiated Player")

func _process(delta: float) -> void:
	_direction = Vector2.ZERO
	
	if Input.is_action_pressed("move_left"):
		_direction = Vector2.LEFT
		_last_faced_direction = _direction
		
	if Input.is_action_pressed("move_right"):
		_direction = Vector2.RIGHT
		_last_faced_direction = _direction
		
	if Input.is_action_just_pressed("jump"):
		movement_component.jump()
	
	if Input.is_action_pressed("normal_attack"):
		_is_attacking = true
		movement_component.stop()

	movement_component.move(_direction * delta)
	animated_sprite.flip_h = _last_faced_direction.x < 0
	
	if is_on_floor():
		if _is_on_air:
			_land()
			_is_on_air = false
	else:
		_is_on_air = true
		
	_handle_animations()
	
	move_and_slide()

# ------------ PUBLIC FUNCTIONS ------------ 
func on_attack_ended():
	_is_attacking = false
	hitbox_component.set_collider_visibility(false)
	movement_component.reset_walk_speed()
	
func on_attack_executed():
	hitbox_component.set_collider_visibility(true)

# ------------ SIGNAL SUBSCRIPTIONS ------------ 
func on_step() -> void:
	_play_step_sound()
	_play_step_particles()

func _on_movement_component_on_jump_pressed(jump_force: float) -> void:
	if is_on_floor():
		velocity.y = jump_force
		jump_sound_component.play_audio(_jump_audio)

# ------------ PRIVATE FUNCTIONS ------------ 
func _handle_animations() -> void:
	if !_can_animate: return
	
	#if !is_on_floor():
		#if velocity.y > 0 and !movement_component.is_touching_the_ground():
			#animation_player.play("idle")
		#else:
			#animation_player.play("idle")
		#return
		#
	#if _direction.length() > 0:
		#animation_player.play("walk")
	#else:
		#pass
		#animation_player.play("idle")

func _land() -> void:
	on_landed.emit()
	_play_step_sound()
	_play_step_particles()
	
func _play_step_sound() -> void:
	var step_sound: AudioStream = step_sound_emitter_component.get_random_audio()
	step_sound_emitter_component.play_audio(step_sound)	

func _play_step_particles() -> void:
	step_particles.restart()
	step_particles.emitting = true
