extends NodeState

@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D
@export var speed : int 

var player : CharacterBody2D

func on_process(delta: float) -> void:
	pass

func on_physics_process(delta: float) -> void:
	var direction : int
	
	if character_body_2d.global_position > player.global_position:
		animated_sprite_2d.flip_h = true
		direction = -1
	elif character_body_2d.global_position < player.global_position:
		animated_sprite_2d.flip_h = false
		direction = 1
	
	var distance = character_body_2d.global_position.distance_to(player.global_position)
	
	if distance > 80:
		animated_sprite_2d.play(AnimationNameConst.RUN)
		character_body_2d.position.x += direction * speed * delta
		#character_body_2d.velocity.x = clamp(character_body_2d.velocity.x, -speed, speed)
	else:
		prepate_attack()
	
	
	character_body_2d.move_and_slide()
	

func enter() -> void:
	player = get_tree().get_nodes_in_group(GlobalGroup.PlayerGroup)[0] as CharacterBody2D
	
func exit() -> void:
	pass

func prepate_attack():
	#character_body_2d.velocity.x = 0
	animated_sprite_2d.play(AnimationNameConst.ATTACK_1)
