extends Node
class_name SoundEmitterComponent

# ------------ SIGNALS ------------ 

# ------------ PUBLIC VARIABLES ------------ 
@export var audio_player: AudioStreamPlayer2D
@export var sounds: Array[AudioStream]

# ------------ PRIVATE VARIABLES ------------ 

# ------------ NATIVE FUNCTIONS ------------ 

# ------------ PUBLIC FUNCTIONS ------------ 
func get_random_audio() -> AudioStream:
	return sounds[randi_range(0, sounds.size() - 1)]

func get_audio_at(index: int) -> AudioStream:
	return sounds[index]

func play_audio(audio: AudioStream):
	audio_player.stream = audio
	audio_player.play()

# ------------ SIGNAL SUBSCRIPTIONS ------------ 
