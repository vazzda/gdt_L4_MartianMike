extends Control

@onready var timeLabel = $TimeLabel
@onready var FPSLabel = $FPS

var timeLabelPrefix = "TIME: "
var fpsLabelPrefix = "FPS: "

func _process(delta):
	setFPS()

func setTime(value):
	timeLabel.text = timeLabelPrefix + str(value)

func setFPS():
	FPSLabel.text = fpsLabelPrefix + str(Engine.get_frames_per_second())
