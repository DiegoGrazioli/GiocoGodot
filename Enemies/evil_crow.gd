extends CharacterBody2D
class_name Enemy3

#Da fixare colore HealthBar e non-aggiornamento quando c'è l'await

const SPEED = 75.0
var life = 20.0
var max_life = life
var makeMove = false
var posx = 0 
var posy = 0 
var atk = 5
@export var lvl = 1

var b # body

var is_attacking = false
var is_inside = false
var HIT_PLAYER = false

var damageIndicator = preload("res://damageIndicator.tscn")

var direction = Vector2.ZERO

var useMoveSlide = true

func _ready():
	life = life * lvl
	atk = atk * lvl
	max_life = life

func _physics_process(delta):
	if is_attacking and $Sprite2D.animation != "Attack":
		is_attacking = false
	$HealthBar.value = life * 100 / max_life
	if makeMove and !is_attacking and life > 0:
		move()
	if life <= 0:
		$Sprite2D.play("Die")
		#await ($Sprite2D.animation_finished)
		#var number = randi_range(0,100)
		#if  number == 15:
		#	Globals.key += 1
		#queue_free()
	if $Sprite2D.animation == "Attack" and $Sprite2D.frame == 2:
		if HIT_PLAYER:
			b.hit(atk)
			HIT_PLAYER = false

func _on_sprite_2d_animation_finished():
	if $Sprite2D.animation == "Die":
		var number = randi_range(0,10)
		if  number == 5:
			Globals.key[lvl-1] += 1
		queue_free()
	elif $Sprite2D.animation == "Hurt":
		$Sprite2D.modulate = Color(1, 1, 1)
		$Sprite2D.play("Idle")
	elif $Sprite2D.animation == "Attack":
		$Sprite2D.modulate = Color(1, 1, 1)
		is_attacking = false
		if is_inside:
			HIT_PLAYER = true
			$Sprite2D.play("Attack")
		else:
			$Sprite2D.play("Idle")

func hit(value, dir):
	position.x += 10 * dir
	move_and_slide()
	if dir > 0:
		$Sprite2D.flip_h = true
		$Sprite2D.position.x = -14
		#$HurtBox.position.x = -14
	else:
		$Sprite2D.flip_h = false
		$Sprite2D.position.x = 14
		#$HurtBox.position.x = 14
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
		is_inside = false
		HIT_PLAYER = false
		is_attacking = false
		
func move():
	
	if direction.x > 0:
		if $Sprite2D.animation != "Hurt":
			$Sprite2D.flip_h = false
			$Sprite2D.position.x = 14
			$Area2D/CollisionShape2D.position.x = 14.5
		#$HurtBox.position.x = -14
	else:
		if $Sprite2D.animation != "Hurt":
			$Sprite2D.flip_h = true
			$Area2D/CollisionShape2D.position.x = -42.5
			$Sprite2D.position.x = -14
		#$HurtBox.position.x = 14
		
	# Calculate the direction vector towards the player
	if $Sprite2D.animation != "Hurt":
		direction.x = Globals.playerPos.x - (position.x + posx)
		direction.y = Globals.playerPos.y - (position.y + posy)
		direction = direction.normalized()
	# Calculate the enemy's velocity and rotation
	var velocity = direction * SPEED
	
	# Move the enemy smoothly
	var delta = get_process_delta_time()
	position += velocity * delta
	if useMoveSlide:
		move_and_slide()
	

func _on_area_2d_2_body_entered(body):
	if body.name == "Player":
		makeMove = true


func _on_area_2d_2_body_exited(body):
	if body.name == "Player":
		makeMove = false



func _on_area_2d_3_body_entered(body):
	useMoveSlide = false


func _on_area_2d_3_body_exited(body):
	useMoveSlide = true
