extends StaticBody2D
class_name Chest

var item
var possibleItems = Array()


func _ready():
	possibleItems.push_back(ListOfItems.spada_di_ferro)
	possibleItems.push_back(ListOfItems.spada_di_rame)
	possibleItems.push_back(ListOfItems.pugnale_rotto_di_ferro)

func is_closed():
	return $Closed.visible
	
func open():
	var yo = randi_range(0, possibleItems.size()-1)
	item = possibleItems[yo]
	Globals.itemsOwned.push_back(item)
	$Closed.visible = false
	$Opened.visible = true
	$CPUParticles2D.emitting = false
