extends Node2D

@onready var sprite_in: Sprite2D = $Sprite2D


func _ready():
	sprite_in.scale = Vector2(2, 2)

	var units: Array[GoblinEnemy] = [
		GoblinEnemy.new(GoblinEnemy.Type.MELEE),
		GoblinEnemy.new(GoblinEnemy.Type.MELEE).with_level(2),
		GoblinEnemy.new(GoblinEnemy.Type.MELEE).with_level(5),
		GoblinEnemy.new(GoblinEnemy.Type.MAGE),
		GoblinEnemy.new(GoblinEnemy.Type.RANGE),
	]

	for unit in units:
		print(unit.damage)
