class_name Warrior 
extends CharacterBody2D

# ------------ SIGNALS ------------ 

# ------------ PUBLIC VARIABLES ------------ 
@export var animation_player: AnimationPlayer
@export var sprite: AnimatedSprite2D
@export var health_component: HealthComponent
@export var hurtbox_component: HurtboxComponent

# ------------ PRIVATE VARIABLES ------------ 

# ------------ NATIVE FUNCTIONS ------------ 
func _ready() -> void:
	sprite.flip_h = true
	health_component.connect("health_reached_zero", Callable.create(self, "_on_died"))

func _process(_delta: float) -> void:
	animation_player.play("idle")
	move_and_slide()
	
# ------------ PRIVATE FUNCTIONS ------------ 

# ------------ PUBLIC FUNCTIONS ------------ 

# ------------ SIGNAL SUBSCRIPTIONS ------------ 

func _on_died():
	print("DIED - from " + name + "'s main script")
	hurtbox_component.show_final_hit_flash()
