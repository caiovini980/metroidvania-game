extends CanvasLayer
signal start_game

var message_to_show
var message_timer
var start_button
var score_label

# Called when the node enters the scene tree for the first time.
func _ready():
	message_to_show = $Message
	message_timer = $MessageTimer
	start_button = $StartButton
	score_label = $ScoreLabel

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func show_message(text):
	message_to_show.text = text
	message_to_show.show()
	message_timer.start()
	
func show_game_over():
	show_message("Game Over")
	await message_timer.timeout
	
	message_to_show.text = "Dodge the creeps!"
	message_to_show.show()
	
	# Add a 1s delay
	await get_tree().create_timer(1.0).timeout
	start_button.show()
	
func update_score(score):
	score_label.text = str(score)
	
	
func _on_start_button_pressed():
	start_button.hide()
	start_game.emit()

func _on_message_timer_timeout():
	message_to_show.hide()
