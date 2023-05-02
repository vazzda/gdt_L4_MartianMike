extends Node2D

@export var nextLevel:PackedScene = null
@export var levelTime = 5
@export var isFinalLevel: bool = false

@onready var deathzone = $Deathzone
@onready var startPos = $StartPoint
@onready var finish = $Finish
@onready var firstSaw = $Traps/Saw
@onready var firsSpikeBall = $Traps/SpikeBall
@onready var FPSlabel = $FPS
@onready var UI = $UIlayer
@onready var HUD = $UIlayer/HUD

var player = null
var trapsList = null
var timerNode = null
var timeLeft
var levelWinned = false


func _ready():
	player = get_tree().get_first_node_in_group("player")
	if player!=null:
		_resetPlayerPosition()
		
	trapsList = get_tree().get_nodes_in_group("traps")
	for trap in trapsList:
		trap.connect("touched_player", _onTrapTouchedPlayer)
	deathzone.connect("body_entered", _onBodyEneteredToDeathZone)
	
	finish.connect("playerTouched", _onPlayerTouchedFinish)
	
	_createTimer()
	_updateHUD()

func _process(delta):
	_processGlobaHotkeys()
		
		
func _processGlobaHotkeys():
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()	

func _createTimer():
	
	timerNode = Timer.new()
	timerNode.name = "Level timer"
	timerNode.wait_time = 1
	timerNode.connect("timeout", _onTimerTick)
	add_child(timerNode)
	
	_resetTimer()
	timerNode.start()
	
func _onTimerTick():
	if levelWinned:
		return
		
	timeLeft -= 1
	if timeLeft < 0:
		_onLevelTimeout()
	_updateHUD()

func _onLevelTimeout():
	_resetPlayerPosition()

func _resetTimer():
	timeLeft = levelTime


func _onBodyEneteredToDeathZone(body):
	_resetPlayerPosition()

func _onTrapTouchedPlayer(body):
	_resetPlayerPosition()
	
func _resetPlayerPosition():
	player.velocity = Vector2.ZERO
	player.global_position = startPos.getSpawnPosition()
	_resetTimer()
	AudioPlayer.play_sfx("hurt")

func _onPlayerTouchedFinish():
	levelWinned = true
	player.deactivate()
	finish.finish()
	await get_tree().create_timer(0.5).timeout
	
	if isFinalLevel == true:
		UI.showWinScreen(true)
	elif nextLevel:
		get_tree().change_scene_to_packed(nextLevel)

func _updateHUD():
	HUD.setTime(timeLeft)
