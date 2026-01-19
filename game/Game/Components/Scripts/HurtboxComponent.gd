extends Area2D
class_name HurtboxComponent

# ------------ SIGNALS ------------ 

# ------------ PUBLIC VARIABLES ------------ 
@export var health_component: HealthComponent
@export var hit_flash: AnimationPlayer
@export var sprite: AnimatedSprite2D
@export var on_hit_sound_emitter: SoundEmitterComponent 

# ------------ PRIVATE VARIABLES ------------ 

# ------------ NATIVE FUNCTIONS ------------ 
func _ready() -> void:
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
	print("current health from of "+ owner.name + " is " + String.num(health_component.get_current_health()))
	hit_flash.play("hit_flash")
	_play_sound_on_hit()
