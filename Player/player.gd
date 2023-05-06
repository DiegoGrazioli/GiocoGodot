extends CharacterBody2D
var movement = Vector2()

const SPEED = 150.0

var start_attack2 = false #per il secondo attacco
var dash_accel = 1
var enemies = Array()
var life = 100

func _physics_process(delta):
	Globals.life = life
	Globals.playerPos = position
	#movimento
	if $Sprite2D.animation != "Attack1" and $Sprite2D.animation != "Attack2":  #se attacca non si muove
		movement.x = Input.get_axis("LEFT", "RIGHT")
		movement.y = Input.get_axis("UP", "DOWN")
		movement = movement.normalized() 				#normalizzato yeee (ora funziona)
		if movement != Vector2(0, 0): 					#se non metti input il raycast non diventa un punto
			$RayCast2D.target_position.x = movement.x*16
			$RayCast2D.target_position.y = movement.y*16
		if movement.x < 0: 								#risolve errore di dislocazione della CollisionShape quando flippa lo sprite
			$CollisionShape2D.position.x = 5
			$Area2D/HitBox.position.x = -16
		elif movement.x > 0:
			$CollisionShape2D.position.x = -5
			$Area2D/HitBox.position.x = 16
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
		await ($Sprite2D.animation_finished)
		for e in enemies:
				if $Area2D/HitBox.position.x > 0:
					e.hit(5, 1)
				else :
					e.hit(5, -1)
				
	#dash
	if Input.is_action_just_pressed("DASH") and $DashCooldown.is_stopped() and velocity != Vector2(0, 0): #se il cooldown è finito e se non è fermo fai il dash
		dash_accel = 2
		$Sprite2D.play("Dash")
		
	#per barra dash
	Globals.dashBarValue = 50 * ($DashCooldown.wait_time - $DashCooldown.time_left)
	
	#per interazioni
	if Input.is_action_just_pressed("INTERACT") and $RayCast2D.is_colliding():
			var collider = $RayCast2D.get_collider()
			if collider is Chest and collider.is_closed():
				collider.open()
	
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
		
func _on_dash_cooldown_timeout():
	pass


func _on_area_2d_body_entered(body):
	if body is Enemy:
		enemies.push_back(body)

func _on_area_2d_body_exited(body):
	if body is Enemy:
		enemies.erase(body)
		
func hit(value):
	life -= value
	if life <= 0:
		pass
