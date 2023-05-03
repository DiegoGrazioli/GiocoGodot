extends StaticBody2D
class_name Chest

@export var item = ""

func is_closed():
	return $Closed.visible
	
func open():
	$Closed.visible = false
	$Opened.visible = true
	
