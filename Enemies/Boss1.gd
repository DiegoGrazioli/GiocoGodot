extends CharacterBody2D
class_name Enemy5

const SPEED = 90.0
var life = 90.0
var max_life = life
var makeMove = false
var atk = 1.0
var expDrop = 150
@export var lvl = 10
@export var posx = 0
@export var posy = 0

var b # body

var is_attacking = false
var is_inside = false
var HIT_PLAYER = false

var direction = Vector2.ZERO

var damageIndicator = preload("res://damageIndicator.tscn")

var useMoveSlide = true

var cast = false

var updateCamera = false

var en = preload("res://Enemies/blue_demon.tscn")
var index = 0

func _ready():
	life = life * lvl
	atk = atk * lvl
	max_life = life
	$CastParticle.emitting = false

func _physics_process(delta):
	if updateCamera:
		Globals.enemyPos = position
	else:
		Globals.enemyPos = Vector2.ZERO
	Globals.BossLife = life
	if $Sprite2D.animation != "Cast":
		$CastParticle.emitting = false
	
	if is_attacking and $Sprite2D.animation != "Attack":
		is_attacking = false
	if makeMove and !is_attacking and life > 0:
		move()
	if life <= 0:
		$Sprite2D.play("Die")
		#await ($Sprite2D.animation_finished)
		#var number = randi_range(0,100)
		#if  number == 15:
		#	Globals.key += 1
		#queue_free()
	if $Sprite2D.animation == "Attack" and $Sprite2D.frame == 3:
		if HIT_PLAYER:
			b.hit(atk)
			HIT_PLAYER = false

func _on_sprite_2d_animation_finished():
	if $Sprite2D.animation == "Die":
		var number = randi_range(0,10)
		if  number == 5:
			Globals.key[lvl-1] += 1
		Globals.exp += expDrop * lvl
		queue_free()
	elif $Sprite2D.animation == "Hurt":
		$Sprite2D.modulate = Color(1, 1, 1)
		$Sprite2D.play("Idle")
	elif $Sprite2D.animation == "Attack":
		$Sprite2D.modulate = Color(1, 1, 1)
		if is_inside:
			HIT_PLAYER = true
			$Sprite2D.play("Attack")
		else:
			$Sprite2D.play("Idle")
			is_attacking = false
	elif $Sprite2D.animation == "Cast":
		$Sprite2D.play("Idle")
		$CastParticle.emitting = false

func hit(value, dir):
	position.x += 10 * dir
	move_and_slide()
	if dir > 0:
		$Sprite2D.flip_h = false
		$Sprite2D.position.x = -36
		$Area2D/CollisionShape2D.position.x = -40.5
	else:
		$Sprite2D.flip_h = true
		$Sprite2D.position.x = 35
		$Area2D/CollisionShape2D.position.x = 40.5
	if life - value > 0:
		$Sprite2D.modulate = Color(5, 1, 1)
		$Sprite2D.play("Hurt")
		var dmg = damageIndicator.instantiate()
		add_child(dmg)
		dmg.label.text = str(value)
	life -= value
	
func spawningPosition(r):
	var x = randi_range(-r,r)
	var y = randi_range(-r,r)
	position.x = x
	position.y = y


func _on_area_2d_body_entered(body):
	
	if body.name == "Player":
		is_inside = true
		b = body
		HIT_PLAYER = true
		$Sprite2D.play("Attack")
		$Sprite2D.modulate = Color(2, 2, 2)
		is_attacking = true
		#await $Sprite2D.animation_finished
		#if HIT_PLAYER:
		#	body.hit(2)
		
func _on_area_2d_body_exited(body):
	if body.name == "Player":
		HIT_PLAYER = false
		is_inside = false

func move():
	if direction.x > 0:
		if $Sprite2D.animation != "Hurt":
			$Sprite2D.flip_h = true
			$Area2D/CollisionShape2D.position.x = 40.5
			$Sprite2D.position.x = 35
	else:
		if $Sprite2D.animation != "Hurt":
			$Sprite2D.flip_h = false
			$Area2D/CollisionShape2D.position.x = -40.5
			$Sprite2D.position.x = -36
	
	# Calculate the direction vector towards the player
	if $Sprite2D.animation != "Hurt":
		direction.x = Globals.playerPos.x - (position.x)
		direction.y = Globals.playerPos.y - (position.y)
		direction = direction.normalized()
	
	# Calculate the enemy's velocity and rotation
	var velocity = direction * SPEED
	
	# Move the enemy smoothly
	var delta = get_process_delta_time()
	position += velocity * delta
	if useMoveSlide:
		move_and_slide()

	posx = position.x
	posy = position.y
	
func _on_area_2d_2_body_entered(body):
	if body.name == "Player":
		makeMove = true
		cast = false

func _on_area_2d_2_body_exited(body):
	if body.name == "Player":
		makeMove = false
		cast = true
		$CastTimer.start()


func _on_area_2d_3_body_entered(body):
	useMoveSlide = false


func _on_area_2d_3_body_exited(body):
	useMoveSlide = true


func _on_cast_range_body_entered(body):
	if body.name == "Player":
		cast = true
		$CastTimer.start()

func _on_cast_range_body_exited(body):
	if body.name == "Player":
		cast = false


func _on_cast_timer_timeout():
	if cast:
		$Sprite2D.play("Cast")
		$CastParticle.emitting = true
		var e = $BlueDemon.duplicate()
		e.name = str(index)
		index += 1
		#e.position.x = position.x + 100
		#e.position.y = position.y + 100
		e.posx = posx
		e.posy = posy
		e.spawningPosition(50)
		e.visible = true
		add_child(e)
		$CastTimer.start()
		


func _on_boss_bar_body_entered(body):
	if body.name == "Player":
		Globals.showBar = true
		updateCamera = true


func _on_boss_bar_body_exited(body):
	if body.name == "Player":
		Globals.showBar = false
		updateCamera = false
