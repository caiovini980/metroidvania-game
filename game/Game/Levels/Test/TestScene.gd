extends Node

# ------------ SIGNALS ------------ 

# ------------ PUBLIC VARIABLES ------------ 
@export var Managers: Array[ManagerBase]

# ------------ PRIVATE VARIABLES ------------ 

# ------------ NATIVE FUNCTIONS ------------ 
func _ready():
	print("Initializing managers on Test Scene")
	for manager in Managers:
		manager.initialize()

func _process(delta):
	for manager in Managers:
		manager.tick(delta)

# ------------ PUBLIC FUNCTIONS ------------ 

# ------------ SIGNAL SUBSCRIPTIONS ------------ 
