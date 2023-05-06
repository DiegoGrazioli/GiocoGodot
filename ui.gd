extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ProgressBar.value = Globals.dashBarValue
	$Label.text = "X: " + str(int(Globals.playerPos.x) / 16) + "  Y: " + str(int(Globals.playerPos.y) / 16)
	$PlayerLife.value = Globals.life
	$LabelKey.text = "Keys: " + str(Globals.key)
