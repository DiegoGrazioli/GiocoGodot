extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.life = 0
	$Player/Sprite2D.play("Hurt", 0.25)
	$AnimationPlayer.play("Death")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	


func _on_sprite_2d_animation_finished():
	if $Player/Sprite2D.animation == "Hurt" and Globals.life == 0:
		$Player/Sprite2D.play("Death")


func _on_retry_pressed():
	Globals.load = true
	get_tree().change_scene_to_file("res://game.tscn")


func _on_to_main_menu_pressed():
	get_tree().change_scene_to_file("res://MainMenu.tscn")
