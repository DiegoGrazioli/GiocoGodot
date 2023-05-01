extends CharacterBody2D
var movement = Vector2()

const SPEED = 300.0

var start_attack2 = false #per il secondo attacco
var dash_accel = 1

func _physics_process(delta):
	
	#movimento
	if $Sprite2D.animation != "Attack1" and $Sprite2D.animation != "Attack2":  #se attacca non si muove
		movement.x = Input.get_axis("LEFT", "RIGHT")
		movement.y = Input.get_axis("UP", "DOWN")
		movement = movement.normalized() #normalizzato yeee (ora funziona)
		velocity = movement * SPEED * dash_accel
	else :
		velocity = Vector2(0, 0)
	
	#animazioni
	if (velocity.y != 0 or velocity.x != 0) and $Sprite2D.animation != "Attack1" and $Sprite2D.animation != "Attack2" and $Sprite2D.animation != "Dash":
		$Sprite2D.play("Walk")
	elif $Sprite2D.animation != "Attack1" and $Sprite2D.animation != "Attack2" and $Sprite2D.animation != "Dash":
		$Sprite2D.play("Idle")
	if velocity.x > 0:
		$Sprite2D.flip_h = false
	elif velocity.x < 0:
		$Sprite2D.flip_h = true
	
	#per dash (per evitare che slitti negli ultimi fotogrammi)
	if $Sprite2D.animation == "Dash" and $Sprite2D.frame == 5:
		dash_accel = 1
	
	#attacco
	if Input.is_action_just_pressed("ATTACK"):
		if $Sprite2D.animation != "Attack1":
			$Sprite2D.play("Attack1")
		else:
			start_attack2 = true
	
	#dash
	if Input.is_action_just_pressed("DASH") and $DashCooldown.is_stopped() and velocity != Vector2(0, 0): #se il cooldown è finito e se non è fermo fai il dash
		dash_accel = 3
		$Sprite2D.play("Dash")

	move_and_slide()



func _on_sprite_2d_animation_finished():
	if $Sprite2D.animation == "Attack1": #quando finisce di attaccare torna all'animazione standard
		if start_attack2 == false:
			$Sprite2D.play("Idle")
		else:
			start_attack2 = false
			$Sprite2D.play("Attack2")
	elif $Sprite2D.animation == "Attack2":
		$Sprite2D.play("Idle")
	elif $Sprite2D.animation == "Dash":
		$Sprite2D.play("Idle")
		$DashCooldown.start()
