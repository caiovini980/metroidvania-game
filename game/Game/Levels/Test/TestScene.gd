extends Node

@export var Managers: Array[ManagerBase]
	
# Called when the node enters the scene tree for the first time.
func _ready():
	print("Initializing managers on Test Scene")
	for manager in Managers:
		manager.initialize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for manager in Managers:
		manager.tick(delta)
