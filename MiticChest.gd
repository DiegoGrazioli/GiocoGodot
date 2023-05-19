extends StaticBody2D
class_name Mitic_chest

var item
var possibleItems = Array()
@export var is_opened = false

func _ready():
	possibleItems.push_back(ListOfItems.spadone_in_rubino)
	possibleItems.push_back(ListOfItems.spadone_in_smeraldo)
	possibleItems.push_back(ListOfItems.spada_in_smeraldo)
	possibleItems.push_back(ListOfItems.spada_in_rubino)

func is_closed():
	return $Closed.visible
	
func open():
	var yo = randi_range(0, possibleItems.size()-1)
	item = possibleItems[yo]
	Globals.itemsOwned.push_back(item)
	$Closed.visible = false
	$Opened.visible = true
	$CPUParticles2D.emitting = false
	is_opened = true
