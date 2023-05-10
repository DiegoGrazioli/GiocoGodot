extends CharacterBody2D
class_name Enemy

const SPEED = 150.0
var life = 10.0
var max_life = life
var makeMove = false
var posx = 0 
var posy = 0 

var b

var HIT_PLAYER = false

func _ready():
	pass


func _physics_process(delta):
	$HealthBar.value = life * 100 / max_life
	if makeMove:
		move()
	if life <= 0:
		$Sprite2D.play("Die")
		var number = randi_range(0,100)
		if  number == 15:
			Globals.key += 1

func _on_sprite_2d_animation_finished():
	if $Sprite2D.animation == "Die":
		queue_free()
		pass
	elif $Sprite2D.animation == "Hurt":
		$Sprite2D.modulate = Color(1, 1, 1)
		$Sprite2D.play("Idle")
	elif $Sprite2D.animation == "Attack":
		$Sprite2D.modulate = Color(1, 1, 1)
		$Sprite2D.play("Idle")
		if HIT_PLAYER:
			b.hit(2)

func hit(value, dir):
	position.x += 10 * dir
	if dir > 0:
		$Sprite2D.flip_h = false
	else:
		$Sprite2D.flip_h = true
	if life - value > 0:
		$Sprite2D.modulate = Color(10, 1, 1)
		$Sprite2D.play("Hurt")
	life -= value
	
func spawningPosition(r):
	var x = randi_range(-r,r)
	var y = randi_range(-r,r)
	position.x = x
	position.y = y


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		HIT_PLAYER = true
		$Sprite2D.play("Attack")
		$Sprite2D.modulate = Color(2, 2, 2)
		b = body
		
func _on_area_2d_body_exited(body):
	if body.name == "Player":
		HIT_PLAYER = false

func move():
	# Set the enemy's speed and rotation speed
	var speed = 25
	
	# Calculate the direction vector towards the player
	var direction = Vector2.ZERO
	direction.x = Globals.playerPos.x - (position.x + posx)
	direction.y = Globals.playerPos.y - (position.y + posy)
	direction = direction.normalized()
	if direction.x > 0:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false
	
	# Calculate the enemy's velocity and rotation
	var velocity = direction * speed
	
	# Move the enemy smoothly
	var delta = get_process_delta_time()
	position += velocity * delta


func _on_area_2d_2_body_entered(body):
	if body.name == "Player":
		makeMove = true


func _on_area_2d_2_body_exited(body):
	if body.name == "Player":
		makeMove = false
