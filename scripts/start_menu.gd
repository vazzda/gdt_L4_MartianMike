extends Control

@onready var startButton = $Start
@onready var quitButton = $Quit

func _ready():
	startButton.connect("pressed", _onStartPressed)
	quitButton.connect("pressed", _onQuitPressed)

func _onStartPressed():
	get_tree().change_scene_to_file("res://level.tscn")
	
func _onQuitPressed():
	get_tree().quit()
