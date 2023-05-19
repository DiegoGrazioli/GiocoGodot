extends Node

#Comune:
#29=Spada di ferro
#30=Spada di rame
#58=Pugnale rotto di rame
#57=Pugnale rotto di ferro
#61=Spadone di ferro
#62=Spadone di rame
#45=Pugnale di ferro

var spada_di_ferro = {
	nome = "Spada di ferro",
	atk = 2.0,
	speed = 1.0,
	weight = 2.5,
	sprite = preload("res://assets/Items/swords/rpg_icons29.png")
}

var spada_di_rame = {
	nome = "Spada di rame",
	atk = 1.0,
	speed = 1.2,
	weight = 2,
	sprite = preload("res://assets/Items/swords/rpg_icons30.png")
}

var pugnale_rotto_di_rame = {
	nome = "Pugnale rotto di rame",
	atk = 0.2,
	speed = 2.0,
	weight = 0.65,
	sprite = preload("res://assets/Items/swords/rpg_icons58.png")
}

var pugnale_rotto_di_ferro = {
	nome = "Pugnale rotto di ferro",
	atk = 0.5,
	speed = 1.5,
	weight = 1.5,
	sprite = preload("res://assets/Items/swords/rpg_icons57.png")
}

var spadone_di_ferro = {
	nome = "Spadone di ferro",
	atk = 3,
	speed = 0.5,
	weight = 2,
	sprite = preload("res://assets/Items/swords/rpg_icons61.png")
}

var spadone_di_rame = {
	nome = "Spadone di rame",
	atk = 2.5,
	speed = 0.8,
	weight = 1.8,
	sprite = preload("res://assets/Items/swords/rpg_icons62.png")
}

var pugnale_in_rame = {
	nome = "Pugnale in rame",
	atk = 1.3,
	speed = 1.9,
	weight = 0.6,
	sprite = preload("res://assets/Items/swords/rpg_icons62.png")
}

#Raro:
#89=Ascia di ferro
#91=Ascia di rame
#93=Ascia di ferro doppia
#94=Ascia di rame doppia

var ascia_di_ferro = {
	nome = "Ascia di ferro",
	atk = 3.5,
	speed = 2.5,
	weight = 4,
	sprite = preload("res://assets/Items/axes/rpg_icons89.png")
}

var ascia_di_rame = {
	nome = "Ascia di rame",
	atk = 3.2,
	speed = 2.1,
	weight = 3.5,
	sprite = preload("res://assets/Items/axes/rpg_icons91.png")
}

var ascia_di_ferro_doppia = {
	nome = "Ascia di ferro doppia",
	atk = 4.5,
	speed = 3,
	weight = 6,
	sprite = preload("res://assets/Items/axes/rpg_icons93.png")
}

var ascia_di_rame_doppia = {
	nome = "Ascia di rame doppia",
	atk = 3.5,
	speed = 2.5,
	weight = 4,
	sprite = preload("res://assets/Items/axes/rpg_icons94.png")
}

#Mitico:
#26=Spada in rubino
#27=Spada in smeraldo
#62=Spadone in rubino
#63=Spadone in smeraldo

var spada_in_smeraldo = {
	nome = "Spada in smeraldo",
	atk = 5,
	speed = 1.7,
	weight = 2,
	sprite = preload("res://assets/Items/swords/rpg_icons27.png")
}

var spada_in_rubino = {
	nome = "Spada in rubino",
	atk = 4.6,
	speed = 1.2,
	weight = 2.8,
	sprite = preload("res://assets/Items/swords/rpg_icons26.png")
}

var spadone_in_smeraldo = {
	nome = "Spadone in smeraldo",
	atk = 6,
	speed = 1,
	weight = 6,
	sprite = preload("res://assets/Items/swords/rpg_icons63.png")
}

var spadone_in_rubino = {
	nome = "Spadone in rubino",
	atk = 5,
	speed = 0.7,
	weight = 8,
	sprite = preload("res://assets/Items/swords/rpg_icons62.png")
}
