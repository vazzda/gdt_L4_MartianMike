extends Node2D

@onready var deathzone = $Deathzone
@onready var startPosition = $StartPosition
@onready var player = $Player
@onready var firstSaw = $Traps/Saw
@onready var firsSpikeBall = $Traps/SpikeBall
@onready var FPSlabel = $FPS

var trapsList


func _ready():
	deathzone.connect("body_entered", _onBodyEneteredToDeathZone)
	trapsList = get_tree().get_nodes_in_group("traps")
	for trap in trapsList:
		trap.connect("touched_player", _onTrapTouchedPlayer)
	

func _process(delta):
	_processGlobaHotkeys()
	_countFPS()
		
		
func _processGlobaHotkeys():
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()	


func _onBodyEneteredToDeathZone(body):
	_resetPlayerPosition(body)

func _onTrapTouchedPlayer(body):
	_resetPlayerPosition(body)
	
func _resetPlayerPosition(body):
	player.velocity = Vector2.ZERO
	player.global_position = startPosition.global_position
	
func _countFPS():
	FPSlabel.text = str(Engine.get_frames_per_second())
