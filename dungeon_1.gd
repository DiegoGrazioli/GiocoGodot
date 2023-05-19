extends Node2D

var enemiesRemaining = 5
var enemies = [true, true, true, true, true]
var dungeonFinished = false

func _ready():
	$UI/BossBar.visible = true
	$Chest2.visible = false
	$Chest2/CollisionShape2D.disabled = true
	$Chest3.visible = false
	$Chest3/CollisionShape2D.disabled = true
	$Chest4.visible = false
	$Chest4/CollisionShape2D.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $EvilCrow == null:
		enemies[0] = false
	if $EvilCrow2 == null:
		enemies[1] = false
	if $BlueDemon == null:
		enemies[2] = false
	if $BlueDemon2 == null:
		enemies[3] = false
	if $BlueDemon3 == null:
		enemies[4] = false
	
	enemiesRemaining = 0
	for i in enemies:
		if i == true:
			enemiesRemaining += 1
	
	$UI/BossBar.value = enemiesRemaining * 100 / enemies.size()
	
	if enemiesRemaining == 0:
		$Chest2.visible = true
		$Chest2/CollisionShape2D.disabled = false
		$Chest3.visible = true
		$Chest3/CollisionShape2D.disabled = false
		$Chest4.visible = true
		$Chest4/CollisionShape2D.disabled = false
		dungeonFinished = true

	if $Chest2/Opened.visible:
		$Chest3.visible = false
		$Chest3/CollisionShape2D.disabled = true
		$Chest4.visible = false
		$Chest4/CollisionShape2D.disabled = true
	
	if $Chest3/Opened.visible:
		$Chest2.visible = false
		$Chest2/CollisionShape2D.disabled = true
		$Chest4.visible = false
		$Chest4/CollisionShape2D.disabled = true
	
	if $Chest4/Opened.visible:
		$Chest3.visible = false
		$Chest3/CollisionShape2D.disabled = true
		$Chest2.visible = false
		$Chest2/CollisionShape2D.disabled = true
	
func _on_dungeon_1_portal_body_entered(body):
	if body.name == "Player" and dungeonFinished:
		get_tree().change_scene_to_file("res://game.tscn")
