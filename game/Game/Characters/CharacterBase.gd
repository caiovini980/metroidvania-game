class_name CharacterBase extends CharacterBody2D

# ------------ SIGNALS ------------ 
signal on_character_died

# ------------ PUBLIC VARIABLES ------------ 
@export var max_health: float
@export var current_health: float
@export var walk_speed: float
@export var gravity: float 

# ------------ PRIVATE VARIABLES ------------ 
# ------------ NATIVE FUNCTIONS ------------ 
# ------------ PUBLIC FUNCTIONS ------------ 
func change_health(amount: float) -> void:
	if (current_health <= 0):
		die()
		return
		
	current_health -= amount
	
func die():
	print(get_parent().name + " died")
	on_character_died.emit(get_parent())
	
func set_initial_position(initialPosition: Vector2) -> void:
	position = initialPosition

# ------------ SIGNAL SUBSCRIPTIONS ------------ 
