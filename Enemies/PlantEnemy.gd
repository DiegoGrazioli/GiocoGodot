extends CharacterBody2D
class_name Enemy4

#Da fixare colore HealthBar

const SPEED = 0.0
var life = 10.0
var max_life = life
var posx = 0 
var posy = 0 
var atk = 3.0

var b # body

var HIT_PLAYER = false
var is_inside = false

var damageIndicator = preload("res://damageIndicator.tscn")

func _ready():
	pass


func _physics_process(delta):
	#$Sprite2D.play("Idle")
	$HealthBar.value = life * 100 / max_life
	move()
	if life <= 0:
		$Sprite2D.play("Die")
		queue_free()
		#await ($Sprite2D.animation_finished)
		#var number = randi_range(0,100)
		#if  number == 15:
		#	Globals.key += 1
		#queue_free()
	if $Sprite2D.animation == "Attack" and $Sprite2D.frame == 5:
		if HIT_PLAYER:
			b.hit(atk)
			HIT_PLAYER = false

func _on_sprite_2d_animation_finished():
	if $Sprite2D.animation == "Die":
		var number = randi_range(0,100)
		if  number == 15:
			Globals.key += 1
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

func hit(value, dir):
	#position.x += 10 * dir
	if dir > 0:
		$Sprite2D.flip_h = true
		$Area2D/CollisionShape2D.position.x = -14
	else:
		$Sprite2D.flip_h = false 
		$Area2D/CollisionShape2D.position.x = 14
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
		#await $Sprite2D.animation_finished
		#if HIT_PLAYER:
		#	body.hit(2)
		
func _on_area_2d_body_exited(body):
	if body.name == "Player":
		is_inside = false
		HIT_PLAYER = false

func _on_sprite_2d_animation_changed():
	pass # Replace with function body.

func move():
	if 	Globals.playerPos.x > position.x:
		$Sprite2D.flip_h = false 
		$Area2D/CollisionShape2D.position.x = 14
	else :
		$Sprite2D.flip_h = true
		$Area2D/CollisionShape2D.position.x = -14
