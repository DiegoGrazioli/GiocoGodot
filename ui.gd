extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ProgressBar.value = Globals.dashBarValue
	$ColorRect/Label.text = "X: " + str(int(Globals.playerPos.x) / 16) + "  Y: " + str(int(Globals.playerPos.y) / 16)
	$PlayerLife.value = Globals.life * 100 / Globals.maxHealth
	$ColorRect2/LabelKey.text = "Keys: " + str(Globals.key)

	$Control/Item/Nome.text = Globals.itemsOwned[Globals.currentItem].nome
	$Control/Item/Atk.text = "Atk: " + str(Globals.itemsOwned[Globals.currentItem].atk)
	$Control/Item/Speed.text = "Spd: " + str(Globals.itemsOwned[Globals.currentItem].speed)
	$Control/Item/Weight.text = "Weight: " + str(Globals.itemsOwned[Globals.currentItem].weight)
	$Control/Item/Sprite.texture = Globals.itemsOwned[Globals.currentItem].sprite
	
	if $ProgressBar.value > 98 and $ProgressBar.value != 100:
		$AnimationPlayer.play("ProgBarBlink")
