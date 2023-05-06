extends Area2D

var index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Slime.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.name == "player":
		$Timer.start()
		
func _on_timer_timeout():
	var e = $Slime.duplicate()
	e.name = str(index)
	index += 1
	e.spawningPosition(250)
	e.visible = true
	add_child(e)
	$Timer.start()
