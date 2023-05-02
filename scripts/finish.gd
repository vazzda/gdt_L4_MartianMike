extends Area2D

@onready var sprite = $AnimatedSprite2D
signal playerTouched


func finish():
	sprite.play("touch")

func _ready():
	self.connect("body_entered", _onBodyEntered)
	
func _onBodyEntered(body):
	if body is Player:
		emit_signal("playerTouched")
