class_name CharacterManager extends ManagerBase

# visible variables
@export var player_character: PackedScene
@export var player_spawn_position: Marker2D

# local variables
@export var characters_instantiated: Dictionary[String, CharacterBase]

func initialize() -> void:
	# check variables
	if player_spawn_position == null:
		player_spawn_position = $PlayerSpawnPosition
	
	# initialize player
	var player = player_character.instantiate()
	player.set_position(player_spawn_position.position)
	add_child(player)
	
	# cache it
	characters_instantiated[player.name] = player
	
	print("Initialized Character Manager")
	
func tick(delta: float) -> void:
	if characters_instantiated.size() > 0:
		for character in characters_instantiated:
			characters_instantiated[character].update(delta)
