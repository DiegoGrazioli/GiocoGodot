extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Container/AnimatedSprite2D.play("default")



func _on_animated_sprite_2d_animation_finished():
	get_tree().change_scene_to_file("res://MainMenu.tscn")
