extends CanvasLayer

@onready var WinScreen = $WiinScreen

func showWinScreen(flag: bool):
	WinScreen.visible = flag
