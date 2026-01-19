extends Node
class_name HealthComponent

# ------------ SIGNALS ------------ 
signal health_reached_zero

# ------------ PUBLIC VARIABLES ------------ 
@export var max_health: float

# ------------ PRIVATE VARIABLES ------------ 
var _current_health: float

# ------------ NATIVE FUNCTIONS ------------ 
func _ready():
	_current_health = max_health

# ------------ PUBLIC FUNCTIONS ------------ 
func get_current_health() -> float:
	return _current_health
	
func apply_to_health(value: float) -> void:
	_current_health += value
	
	if _current_health <= 0:
		_current_health = 0
		health_reached_zero.emit()
		
# ------------ SIGNAL SUBSCRIPTIONS ------------ 
