extends CanvasLayer

func _ready():
	pass

func _process(delta):
	$Pause/Container/Upgrade/Life/Cost.text = str(pow(2, Globals.maxHealth - 20))
	$Pause/Container/HP.text = str(Globals.life) + "/" + str(Globals.maxHealth)

	#$Pause/Container/Upgrade/Life/Cost.value = str(pow(2, Globals.maxHealth - 20))
	#$Pause/Container/HP.text = str(Globals.life) + "/" + str(Globals.maxHealth)
