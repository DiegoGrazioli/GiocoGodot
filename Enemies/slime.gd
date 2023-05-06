extends CharacterBody2D
class_name Enemy


const SPEED = 150.0
var life = 10

func _ready():
	pass


func _physics_process(delta):
	
	if life <= 0:
		$Sprite2D.play("Die")
		await ($Sprite2D.animation_finished)
		queue_free()
	else: 
		await ($Sprite2D.animation_finished)
		$Sprite2D.play("Idle")


func _on_sprite_2d_animation_finished():
	if $Sprite2D.animation == "Die":
		pass

func hit(value, dir):
	position.x += 10 * dir
	if dir > 0:
		$Sprite2D.flip_h = false
	else:
		$Sprite2D.flip_h = true
	if life - value > 0:
		$Sprite2D.play("Hurt")
		await $Sprite2D.animation_finished
	life -= value
	
func spawningPosition(r):
	var x = randi_range(-r,r)
	var y = randi_range(-r,r)
	position.x = x
	position.y = y


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		$Sprite2D.play("Attack")
		await $Sprite2D.animation_finished
		body.hit(2)
