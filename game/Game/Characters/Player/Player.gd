class_name Player extends CharacterBase

# ------------ SIGNALS ------------ 
signal on_landed

# ------------ PUBLIC VARIABLES ------------ 
@export_group("Animation")
@export var animation_player: AnimationPlayer
@export var animated_sprite: AnimatedSprite2D

@export_group("Particles")
@export var step_particles: GPUParticles2D

@export_group("Components")
@export var movement_component: MovementComponent
@export var collision_component: CollisionComponent
@export var step_sound_emitter_component: SoundEmitterComponent
@export var jump_sound_emitter_component: SoundEmitterComponent

# ------------ PRIVATE VARIABLES ------------ 
var _jump_audio: AudioStream
var _is_on_air: bool = false

# ------------ NATIVE FUNCTIONS ------------ 
func _enter_tree():
	gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	
	if animation_player == null:
		animation_player = $AnimationPlayer
		
	if animated_sprite == null:
		animated_sprite = $Sprite
		
	if step_particles == null:
		step_particles = $StepParticles
		
	if movement_component == null:
		movement_component = $MovementComponent
		
	if step_sound_emitter_component == null:
		step_sound_emitter_component = $StepSoundEmitter
		
	if jump_sound_emitter_component == null:
		jump_sound_emitter_component = $JumpSoundEmitter
		
	# setup jump sound correctly
	var _jump_audio_player: AudioStreamPlayer2D = jump_sound_emitter_component.audio_player
	_jump_audio_player.volume_db = -10
	_jump_audio = jump_sound_emitter_component.get_audio_at(0)
		
	print("Instantiated Player")

func update(delta: float) -> void:
	_handle_movement(delta)
	_handle_animations()
	
	move_and_slide()

# ------------ PUBLIC FUNCTIONS ------------ 

# ------------ SIGNAL SUBSCRIPTIONS ------------ 
func on_step() -> void:
	_play_step_sound()
	_play_step_particles()

func _on_movement_component_on_jump_pressed() -> void:
	if is_on_floor():
		velocity.y = movement_component.get_jump_force()
		jump_sound_emitter_component.play_audio(_jump_audio)

# ------------ PRIVATE FUNCTIONS ------------ 
func _handle_movement(delta: float) -> void:
	movement_component.handle_movement(delta)
	animated_sprite.flip_h = movement_component.is_facing_right()
	
	if !is_on_floor():
		_apply_gravity(delta)
		_is_on_air = true
		return
		
	if _is_on_air:
		_land()
		_is_on_air = false

func _handle_animations() -> void:
	if !is_on_floor():
		if velocity.y > 0 and !movement_component.is_touching_the_ground():
			animation_player.play("falling")
		else:
			animation_player.play("jump")
		return
		
	if movement_component.get_move_direction().length() > 0:
		animation_player.play("walk")
	else:
		animation_player.play("idle")

func _apply_gravity(delta: float) -> void:
	velocity.y += gravity * delta

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
