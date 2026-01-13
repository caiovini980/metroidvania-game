extends RigidBody2D

@export var collision_shape_2d: CollisionShape2D
@export var animated_sprite_2d: AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if collision_shape_2d == null:
		collision_shape_2d = get_node("CollisionShape2D")
		
	if animated_sprite_2d == null:
		animated_sprite_2d = get_node("AnimatedSprite2D")
		
	var mob_types: Array = Array(animated_sprite_2d.sprite_frames.get_animation_names())
	animated_sprite_2d.animation = mob_types.pick_random()
	animated_sprite_2d.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
