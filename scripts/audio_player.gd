extends Node

var hurtSound = preload("res://assets/audio/hurt.wav")
var jumpSound = preload("res://assets/audio/jump.wav")

func play_sfx(sfx_name: String):
	var asp = AudioStreamPlayer.new()
	
	var stream = null
	if sfx_name == "hurt":
		stream = hurtSound
	elif sfx_name == "jump":
		stream = jumpSound
	else:
		print("invalid sfx name")
		return
		
	asp.stream = stream
	asp.name = "SFX"
	add_child(asp)
	asp.play()
	
	await asp.finished
	asp.queue_free()
