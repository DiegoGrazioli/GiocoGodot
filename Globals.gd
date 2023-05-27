extends Node

var dashBarValue = 100
var playerDamageMultiplier = 1

var playerPos = Vector2.ZERO
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


var key = [0, 0, 0, 0, 0, 0]

var itemsOwned = Array()
var currentItem = 0

func _physics_process(delta):
	playerLvl = int(log(exp) / log(2))
		
