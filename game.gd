extends Node2D

@onready var player = $Player

var paused = false

func _ready():
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

#life
func _on_button_pressed():
	if Globals.exp - pow(2, Globals.maxHealth - 20) >= 0:
		Globals.exp -= pow(2, Globals.maxHealth - 20)
		Globals.maxHealth += 1
		Globals.life += 1


func _on_esc_pressed():
	$CanvasLayer2.visible = false
	$Player.position.y += 10
