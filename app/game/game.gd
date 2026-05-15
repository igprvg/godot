extends Node2D


func _ready():
	var name: String = "Goblin"

	var info: Dictionary[String, Variant] = {
		"name": name,
		"damage": 10.0,
		"hp": 100.0,
	}

	print(info)
