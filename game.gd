extends Node2D

@onready var player = $Player

func _ready():
	player.position = Globals.overworldPos
	$UI/BossBar.visible = false
	$UI/OverWordOccluder.visible = false
	$UI/OverWordOccluder/LabelKey.visible = false
	$UI/PlayerPosition.visible = true
func _process(delta):
	pass

func _on_dungeon_1_portal_body_entered(body):
	if body.name == "Player" and Globals.key[0] > 0:
		Globals.key[0] -= 1
		var p = Vector2(body.position.x, body.position.y+50)
		Globals.overworldPos = p
		get_tree().change_scene_to_file("res://dungeon_1.tscn")
