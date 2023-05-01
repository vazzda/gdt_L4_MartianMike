extends Node2D

@onready var area2D = $Area2D

signal touched_player

func _ready():
	area2D.connect("body_entered", _onPlayerEntered)
	
func _onPlayerEntered(body):
	if body is Player:
		touched_player.emit(body)
