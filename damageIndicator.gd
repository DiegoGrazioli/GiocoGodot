extends Node2D

var SPEED = 30
var FRICTION = 15
var SHIFT_DIRECTION = Vector2.ZERO

@onready var label = $Label
@onready var anim = $AnimationPlayer

func _ready():
	SHIFT_DIRECTION = Vector2(randi_range(-1, 1), randi_range(-1, 1))
	$AnimationPlayer.play("showDamage")
	
func _process(delta):
	global_position += SPEED * SHIFT_DIRECTION * delta
	SPEED = max(SPEED - FRICTION * delta, 0)


func _on_animation_player_animation_finished(anim_name):
	queue_free()
