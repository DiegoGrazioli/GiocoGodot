extends Area2D

var recoveryAmount = 0.01
var isInside = false
var damageIndicator = preload("res://damageIndicator.tscn")
var player = null

func _ready():
	pass
	

func _on_body_exited(body):
	if body.name == "Player":
		isInside = false

func _on_timer_timeout():
	if isInside:
		Globals.life += int(Globals.maxHealth * recoveryAmount)
		if Globals.life > Globals.maxHealth:
			Globals.life = Globals.maxHealth
		else:
			player.regenAnimation(Globals.maxHealth * recoveryAmount)

	$Timer.start()

func _on_body_entered(body):
	if body.name == "Player":
		player = body
		isInside = true
		$Timer.start()
