extends Node
class_name GravityComponent

# ------------ SIGNALS ------------ 

# ------------ PUBLIC VARIABLES ------------ 
@export var gravity: float = 980

# ------------ PRIVATE VARIABLES ------------ 

# ------------ NATIVE FUNCTIONS ------------ 

func _process(delta):
	get_parent().velocity.y += gravity * delta

# ------------ PUBLIC FUNCTIONS ------------ 
	
	
# ------------ SIGNAL SUBSCRIPTIONS ------------ 
