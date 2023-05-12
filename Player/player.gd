extends CharacterBody2D
var movement = Vector2()

const SPEED = 150.0

var start_attack2 = false #per il secondo attacco
var dash_accel = 1
var enemies = Array()
var life = 100.0
var atk = 1.0
var dashDamage = false
var shake = false

var lastHit

var attacked = false

var damageIndicator = preload("res://damageIndicator.tscn")

func _ready():
	$CanvasModulate.color.r = 0.6
	$CanvasModulate.color.g = 0.6
	$CanvasModulate.color.b = 0.6
	Globals.maxHealth = life
	Globals.itemsOwned.push_back(ListOfItems.pugnale_rotto_di_rame)

func _physics_process(delta):
	Globals.life = life
	Globals.playerPos = position
	
	#controlla per shake
	if shake:
		var shakeVector = Vector2(randf_range(-1, 1) * 4, randf_range(-1, 1) * 4)
		var tween = $Camera2D.create_tween()
		tween.tween_property($Camera2D, "offset", shakeVector, 0.1)
		$Camera2D.set_process(true)
	
	#controlla per errori grafici
	if !$Sprite2D.animation == "Attack1" and !$Sprite2D.animation == "Attack2" and $AttackEffect.emitting:
		$AttackEffect.emitting = false
	
	$Sprite2D.modulate = Color(1, 1, 1)
	if $Sprite2D.animation == "Hurt":
		$Sprite2D.modulate = Color(5, 1, 1)
		
	if $Sprite2D.animation != "Dash":
		dash_accel = 1
	
	#movimento
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
	
	#animazioni
	if (velocity.y != 0 or velocity.x != 0) and $Sprite2D.animation != "Attack1" and $Sprite2D.animation != "Attack2" and $Sprite2D.animation != "Dash" and $Sprite2D.animation != "Hurt":
		$Sprite2D.play("Walk")
	elif (velocity.y != 0 or velocity.x != 0) and ($Sprite2D.animation != "Attack1" or $Sprite2D.animation != "Attack2") and $Sprite2D.animation != "Dash" and $Sprite2D.animation != "Hurt":
		velocity = movement * SPEED * dash_accel / Globals.itemsOwned[Globals.currentItem].weight
	elif $Sprite2D.animation != "Attack1" and $Sprite2D.animation != "Attack2" and $Sprite2D.animation != "Dash" and $Sprite2D.animation != "Hurt":
		$Sprite2D.play("Idle")
	if velocity.x > 0:
		$Sprite2D.flip_h = false
	elif velocity.x < 0:
		$Sprite2D.flip_h = true
	
	#per dash (per evitare che slitti negli ultimi fotogrammi)
	if $Sprite2D.animation == "Dash" and $Sprite2D.frame == 5:
		dash_accel = 1
	
	#dash
	if Input.is_action_just_pressed("DASH") and $DashCooldown.is_stopped() and velocity != Vector2(0, 0): #se il cooldown è finito e se non è fermo fai il dash
		dash_accel = 2
		$Sprite2D.play("Dash")
		$DashCooldown.start()
		
	#per barra dash
	Globals.dashBarValue = 50 * ($DashCooldown.wait_time - $DashCooldown.time_left)
	
	if Input.is_action_just_pressed("SCROLL_UP"):
		scrolling(true)
	elif Input.is_action_just_pressed("SCROLL_DOWN"):
		scrolling(false)
	
	#per interazioni
	if Input.is_action_just_pressed("INTERACT") and $RayCast2D.is_colliding():
			var collider = $RayCast2D.get_collider()
			if collider is Chest and collider.is_closed():
				collider.open()
	
	if attacked and ($Sprite2D.animation == "Attack1" and $Sprite2D.frame == 6) or ($Sprite2D.animation == "Attack2" and $Sprite2D.frame == 2):
		attacked = false
		for e in enemies:
			if $Area2D/HitBox.position.x > 0:
				if dashDamage:
					e.hit(atk * 2 * Globals.itemsOwned[Globals.currentItem].atk, 1)
				else :
					e.hit(atk * Globals.itemsOwned[Globals.currentItem].atk, 1)
			else :
				if dashDamage:
					e.hit(atk * 2 * Globals.itemsOwned[Globals.currentItem].atk, -1)
				else :
					e.hit(atk * Globals.itemsOwned[Globals.currentItem].atk, -1)
	
	move_and_slide()
	
func scrolling(up_or_down):
	if up_or_down: #up/descresce=true, down/cresce=false
		if Globals.currentItem == 0:
			Globals.currentItem = Globals.itemsOwned.size()-1
		else:
			Globals.currentItem -= 1;
	else:
		if Globals.currentItem == Globals.itemsOwned.size()-1:
			Globals.currentItem = 0
		else:
			Globals.currentItem += 1

func _on_sprite_2d_animation_finished():
	
	if $Sprite2D.animation == "Attack1" or $Sprite2D.animation == "Attack2":
		if $DashCooldown.time_left >= 1.25:
			dashDamage = true
			$EpicAttack.emitting = true
		else:
			dashDamage = false
	
	if $Sprite2D.animation == "Attack1": #quando finisce di attaccare torna all'animazione standard
		if start_attack2 == false:
			$AttackEffect.emitting = false
			$Sprite2D.play("Idle")
		else:
			
			$AttackEffect.lifetime = 1
			$AttackEffect.emitting = true
			$Sprite2D.play("Attack2", Globals.itemsOwned[Globals.currentItem].speed)
	elif $Sprite2D.animation == "Attack2":
		start_attack2 = false
		$AttackEffect.emitting = false
		$Sprite2D.play("Idle")
	elif $Sprite2D.animation == "Dash":
		$Sprite2D.play("Idle")
	elif $Sprite2D.animation == "Hurt":
		$Sprite2D.modulate = Color(1, 1, 1)
		$Sprite2D.play("Idle")
		
func _on_dash_cooldown_timeout():
	start_attack2 = false

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ATTACK"):
		attacked = true
		if $Sprite2D.animation != "Attack1" and !start_attack2:
			$AttackEffect.lifetime = 1
			$AttackEffect.emitting = true
			$Sprite2D.play("Attack1", Globals.itemsOwned[Globals.currentItem].speed)
		else:
			start_attack2 = true

func _on_area_2d_body_entered(body):
	if body is Enemy or body is Enemy2 or body is Enemy3 or body is Enemy4:
		enemies.push_back(body)

func _on_area_2d_body_exited(body):
	if body is Enemy or body is Enemy2 or body is Enemy3 or body is Enemy4:
		enemies.erase(body)
		
func hit(value):
	life -= value
	if life <= 0:
		#$CanvasModulate.color.r = 0.1
		$CanvasModulate.color.g = 0.1
		$CanvasModulate.color.b = 0.1
	else:
		$CanvasModulate.color.g = life * 0.6  / Globals.maxHealth 
		$CanvasModulate.color.b = life * 0.6 / Globals.maxHealth
		pass
	$Sprite2D.modulate = Color(5, 1, 1)
	$Sprite2D.play("Hurt")
	
	#cameraShake
	$Camera2D/ShakeTimer.start()
	shake = true
	
	#damageIndicator
	var dmg = damageIndicator.instantiate()
	add_child(dmg)
	dmg.modulate = Color(2, 2, 2)
	dmg.anim.play("showDamage_player")
	dmg.label.text = str(value)
	
func _on_shake_timer_timeout():
	var tween = $Camera2D.create_tween()
	tween.tween_property($Camera2D, "offset", Vector2(0, 0), 0.1)
	shake = false
