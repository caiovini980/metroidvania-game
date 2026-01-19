extends Area2D
class_name HurtboxComponent

# ------------ SIGNALS ------------ 

# ------------ PUBLIC VARIABLES ------------ 
@export var health_component: HealthComponent

# ------------ PRIVATE VARIABLES ------------ 

# ------------ NATIVE FUNCTIONS ------------ 
func _ready() -> void:
	#area_entered.connect(_on_area_entered.bind)
	connect("area_entered", Callable.create(self, "_on_area_entered"))
	health_component.connect("health_reached_zero", Callable.create(self, "_on_died"))


func _on_area_entered(hitbox: HitboxComponent) -> void:
	if hitbox == null or health_component.get_current_health() <= 0:
		return
	
	print("hitbox detected from " + hitbox.owner.name + " applying damage of " + String.num(hitbox.damage))
	health_component.apply_to_health(-hitbox.damage)
	print("current health from of "+ owner.name + " is " + String.num(health_component.get_current_health()))

func _on_died():
	print("DIED - from hurtbox component of " + owner.name)

# ------------ PUBLIC FUNCTIONS ------------ 

# ------------ SIGNAL SUBSCRIPTIONS ------------ 
