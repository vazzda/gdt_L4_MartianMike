extends Area2D

@onready var animated_sprite = $AnimatedSprite2D

@export var jumpForce = 300

func _ready():
	self.connect("body_entered", _onPlayerEntered)

func _onPlayerEntered(body):
	if body is Player:
		body.jumpByForce(jumpForce)
		animated_sprite.play("run")
