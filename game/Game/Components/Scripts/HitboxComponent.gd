extends Node2D
class_name HitboxComponent

# ------------ SIGNALS ------------ 

# ------------ PUBLIC VARIABLES ------------ 
@export var attack_area: Area2D
@export var collider: CollisionShape2D
@export var damage: float

# ------------ PRIVATE VARIABLES ------------ 

# ------------ NATIVE FUNCTIONS ------------ 

# ------------ PUBLIC FUNCTIONS ------------ 
func set_collider_visibility(isEnabled: bool) -> void:
	attack_area.monitoring = isEnabled
	attack_area.monitorable = isEnabled
	collider.disabled = !isEnabled

# ------------ SIGNAL SUBSCRIPTIONS ------------ 
