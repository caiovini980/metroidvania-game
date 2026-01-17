class_name Warrior 
extends CharacterBody2D

# ------------ SIGNALS ------------ 

# ------------ PUBLIC VARIABLES ------------ 
@export var animation_player: AnimationPlayer
@export var sprite: AnimatedSprite2D

# ------------ PRIVATE VARIABLES ------------ 

# ------------ NATIVE FUNCTIONS ------------ 
func _ready() -> void:
	sprite.flip_h = true

func _process(_delta: float) -> void:
	animation_player.play("idle")
	move_and_slide()
	
# ------------ PUBLIC FUNCTIONS ------------ 

# ------------ SIGNAL SUBSCRIPTIONS ------------ 
