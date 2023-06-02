extends CanvasLayer

func _ready():
	pass

func _process(delta):
	if Globals.loadingComplete:
		$Pause/Container/HPup.amount = Globals.lifeLvl
		$Pause/Container/HPRup.amount = Globals.regenLvl
		$Pause/Container/Atkup.amount = Globals.attackLvl
		$Pause/Container/Speedup.amount = Globals.speedLvl
		Globals.loadingComplete = false
	$Pause/Container/Upgrade/CurrentExp.text = "Punti disponibili: " + str(Globals.availablePoints)
	
	$Pause/Container/Upgrade/Life/Cost.text = "Costo: " + str(pow(2, Globals.lifeLvl-1))
	$Pause/Container/HP.text = str(int(Globals.life)) + "/" + str(Globals.maxHealth)

	$Pause/Container/Upgrade/LifeRecovery/Cost.text = "Costo: " + str(pow(2, Globals.regenLvl-1))
	$Pause/Container/HPRegen.text = str(Globals.regen)

	$Pause/Container/Upgrade/Attack/Cost.text = "Costo: " + str(pow(2, Globals.attackLvl-1))
	$Pause/Container/Atk.text = str(Globals.attack)

	$Pause/Container/Upgrade/Speed/Cost.text = "Costo: " + str(pow(2, Globals.speedLvl-1))
	$Pause/Container/Exp.text = str(Globals.speed)
	
	$Pause/Container/Level.text = str(Globals.playerLvl)
