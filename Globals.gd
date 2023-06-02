extends Node

var dashBarValue = 100
var playerDamageMultiplier = 1

var playerPos
var overworldPos = Vector2(100, 100)

var life = 20
var maxHealth = 20
var lifeLvl = 1

var attack = 1.0
var attackLvl = 1

var regen = 0.1
var regenLvl = 1

var speed = 150.0
var speedLvl = 1

var exp = 1
var playerLvl = 1
var availablePoints = 0

var key = [0, 0, 0, 0, 0, 0]

var itemsOwned = Array()
var currentItem = 0

var config = ConfigFile.new()

var loadingComplete = false

var load = false

func _physics_process(delta):
	if  exp >= pow(2,playerLvl + 1):
		exp -= pow(2,playerLvl + 1)
		playerLvl += 1
		availablePoints += pow(2, playerLvl - 2)
	var index = -1
	for i in itemsOwned:
		index += 1
		var index2 = index
		while index2 < itemsOwned.size()-1:
			index2 += 1
			if i.nome == itemsOwned[index2].nome:
				itemsOwned.remove_at(index)
				break
			
	#playerLvl = int(log(exp) / log(2))

func _ready():
	#load_data()
	if availablePoints == null:
		availablePoints = 0

func save_data():
	config.set_value("Player", "pos", playerPos);
	config.set_value("Player", "max_health", maxHealth);	
	config.set_value("Player", "life", life);
	config.set_value("Player", "life_lvl", lifeLvl);
	config.set_value("Player", "attack", attack);
	config.set_value("Player", "attack_lvl", attackLvl);
	config.set_value("Player", "regen", regen);
	config.set_value("Player", "regen_lvl", regenLvl);
	config.set_value("Player", "speed", speed);
	config.set_value("Player", "speed_lvl", speedLvl);
	config.set_value("Player", "experience", exp);
	config.set_value("Player", "level", playerLvl);
	config.set_value("Player", "key", key);
	config.set_value("Player", "items", itemsOwned);
	config.set_value("Player", "points", availablePoints);
	
	config.save("user://data.cfg")
	
func load_data():
	var err = config.load("user://data.cfg")
	
	if err != OK:
		return
	
	var player_sec = config.get_sections()[0]
	
	playerPos = config.get_value(player_sec, "pos")
	maxHealth = config.get_value(player_sec, "max_health")
	life = config.get_value(player_sec, "life")
	lifeLvl = config.get_value(player_sec, "life_lvl")
	attack = config.get_value(player_sec, "attack")
	attackLvl = config.get_value(player_sec, "attack_lvl")
	regen = config.get_value(player_sec, "regen")
	regenLvl = config.get_value(player_sec, "regen_lvl")
	speed = config.get_value(player_sec, "speed")
	speedLvl = config.get_value(player_sec, "speed_lvl")
	exp = config.get_value(player_sec, "experience")
	playerLvl = config.get_value(player_sec, "level")
	key = config.get_value(player_sec, "key")
	itemsOwned = config.get_value(player_sec, "items")
	availablePoints = config.get_value(player_sec, "points")
	
	loadingComplete = true
