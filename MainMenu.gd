extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_nuova_partita_pressed():
	Globals.load = false
	get_tree().change_scene_to_file("res://game.tscn")


func _on_carica_partita_pressed():
	Globals.load = true
	get_tree().change_scene_to_file("res://game.tscn")


func _on_esci_pressed():
	get_tree().quit()
