extends CharacterBody2D
class_name Player

@onready var animate_sprite = $AnimatedSprite2D

@export var gravity = 400
@export var gravity_cap = 600
@export var speed = 16000
@export var jump_force = 200

var active = true

func activate():
	active = true
	
func deactivate():
	active = false


func jump():
	velocity.y = -jump_force
	AudioPlayer.play_sfx("jump")

func jumpByForce(force):
	velocity.y = -force
	AudioPlayer.play_sfx("jump")


func _physics_process(delta):
	_process_char_movements(delta)

	
func _process_char_movements(delta):
	if is_on_floor()==false && velocity.y < gravity_cap:
		velocity.y += gravity * delta
	
	var direction = 0
	if active:
		if Input.is_action_just_pressed("player_jump") && is_on_floor():
			jump()
			
		direction = Input.get_axis("player_move_left", "player_move_right")
		velocity.x = direction * speed * delta
	
	move_and_slide()
	_updateAnimations(direction)
	
func _updateAnimations(direction):
	if direction != 0:
		animate_sprite.flip_h = (direction == -1)
		
	if is_on_floor():
		if direction == 0:
			animate_sprite.play("idle")
		else:
			animate_sprite.play("run")
	else:
		if velocity.y < 0:
			animate_sprite.play("jump")
		else:
			animate_sprite.play("fall")

	
