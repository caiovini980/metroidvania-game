extends Area2D
class_name HurtboxComponent

# ------------ SIGNALS ------------ 

# ------------ PUBLIC VARIABLES ------------ 
@export var health_component: HealthComponent
@export var hit_flash: AnimationPlayer
@export var sprite: AnimatedSprite2D
@export var on_hit_sound_emitter: SoundEmitterComponent 
@export var knockback_duration: float = 1
@export var knockback_force: float = 100

# ------------ PRIVATE VARIABLES ------------ 
var _knockback_timer: Timer

# ------------ NATIVE FUNCTIONS ------------ 
func _ready() -> void:
	_knockback_timer = $Timer
	
	connect("area_entered", Callable.create(self, "_on_area_entered"))
	sprite.material.set_shader_parameter("is_final_hit", false)
	
func _play_sound_on_hit() -> void:
	var on_hit_sound: AudioStream = on_hit_sound_emitter.get_audio_at(0)
	on_hit_sound_emitter.play_audio(on_hit_sound)

# ------------ PUBLIC FUNCTIONS ------------ 
func show_final_hit_flash() -> void:
	sprite.material.set_shader_parameter("is_final_hit", true)

# ------------ SIGNAL SUBSCRIPTIONS ------------ 
func _on_area_entered(hitbox: HitboxComponent) -> void:
	if hitbox == null or health_component.get_current_health() <= 0:
		return
	
	health_component.apply_to_health(-hitbox.damage)
	hit_flash.play("hit_flash")
	_play_sound_on_hit()
	
	var direction: Vector2 = hitbox.owner.global_position - owner.global_position
	_apply_force_during_time(direction.normalized(), knockback_force, knockback_duration)

func _apply_force_during_time(direction: Vector2, force: float, duration: float) -> void:
	if direction.x <= 0:
		# push left
		owner.velocity.x = force
	else:
		# push right
		owner.velocity.x = -force
		
	_knockback_timer.start(duration)

func _on_timer_timeout():
	owner.velocity.x = 0
