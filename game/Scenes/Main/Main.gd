extends Node

@export var mob: PackedScene
@export var score_timer: Timer
@export var mob_timer: Timer
@export var start_timer: Timer
@export var start_position: Marker2D
@export var mob_spawn_location: PathFollow2D

var score

# NATIVE EVENTS
func _ready():
	#new_game()
	pass
	
func _process(delta):
	pass
	
# FUNCTIONS
func game_over():
	score_timer.stop()
	mob_timer.stop()
	$Music.stop()
	$DeathSound.play()
	$HUD.show_game_over()
	
func new_game():
	# clear the arena
	get_tree().call_group("mobs", "queue_free")
	
	# set original values
	score = 0
	$Player.start(start_position.position)
	start_timer.start()
	
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")

# EVENTS
func _on_player_hit():
	game_over()

func _on_mob_timer_timeout():
	var mob = mob.instantiate()

	# Choose a random location on Path2D.
	mob_spawn_location.progress_ratio = randf()
	mob.position = mob_spawn_location.position

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)

func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_start_timer_timeout():
	mob_timer.start()
	score_timer.start()
	$Music.play()
