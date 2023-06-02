extends Node2D

@onready var player = $Player

var paused = false

func _ready():
	if Globals.load:
		Globals.load = false
		Globals.load_data()
		
	
	player.position = Globals.overworldPos
	$UI/BossBar.visible = false
	$UI/OverWordOccluder.visible = false
	$UI/OverWordOccluder/LabelKey.visible = false
	$UI/PlayerPosition.visible = true
	$CanvasLayer2.visible = false
	
func _process(delta):
	pass

func _on_dungeon_1_portal_body_entered(body):
	if body.name == "Player" and Globals.key[0] > 0:
		Globals.key[0] -= 1
		var p = Vector2(body.position.x, body.position.y+50)
		Globals.overworldPos = p
		get_tree().change_scene_to_file("res://dungeon_1.tscn")


func _on_stats_house_body_entered(body):
	if body.name == "Player":
		$CanvasLayer2.visible = true
		

func _on_stats_house_body_exited(body):
	if body.name == "Player":
		$CanvasLayer2.visible = false
		
#life
func _on_button_pressed():
	if Globals.availablePoints - pow(2, Globals.lifeLvl - 1) >= 0:
		Globals.availablePoints -= pow(2, Globals.lifeLvl - 1)
		Globals.maxHealth += 1
		Globals.life += 1
		Globals.lifeLvl += 1
		$CanvasLayer2/Pause/Container/HPup.amount = Globals.lifeLvl

#lifeRecovery
func _on_button_2_pressed():
	if Globals.availablePoints - pow(2, Globals.regenLvl-1) >= 0:
		Globals.availablePoints -= pow(2, Globals.regenLvl-1)
		Globals.regen += 0.1
		Globals.regenLvl += 1
		$CanvasLayer2/Pause/Container/HPRup.amount = Globals.regenLvl

#attack
func _on_button_3_pressed():
	if Globals.availablePoints - pow(2, Globals.attackLvl-1) >= 0:
		Globals.availablePoints -= pow(2, Globals.attackLvl-1)
		Globals.attack += 0.2
		Globals.attackLvl += 1
		$CanvasLayer2/Pause/Container/Atkup.amount = Globals.attackLvl

#speed
func _on_button_4_pressed():
	if Globals.availablePoints - pow(2, Globals.speedLvl-1) >= 0:
		Globals.availablePoints -= pow(2, Globals.speedLvl-1)
		Globals.speed += 0.1
		Globals.speedLvl += 1
		$CanvasLayer2/Pause/Container/Speedup.amount = Globals.speedLvl

func _on_esc_pressed():
	$CanvasLayer2.visible = false
	$Player.position.y += 10
