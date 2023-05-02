extends Control

@onready var menuButton = $MenuButton
@onready var restartButton = $RestartButton2

func _ready():
	menuButton.connect("pressed", _onMenuPressed)
	restartButton.connect("pressed", _onRestartPressed)
	
func _onMenuPressed():
	get_tree().change_scene_to_file("res://scenes/start_menu.tscn")

func _onRestartPressed():
	get_tree().change_scene_to_file("res://level.tscn")
