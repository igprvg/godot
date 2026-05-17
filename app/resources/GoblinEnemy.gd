class_name GoblinEnemy
extends Resource

enum Type {
	MAGE,
	MELEE,
	RANGE,
}

@export var type: Type = Type.MELEE:
	set(value):
		type = value
		_apply_type_defaults()

var display_name: String = ""
var damage: float = 0.0
var hp: float = 0.0
var has_mana: bool = false
var mana: float = 0.0
var damage_type: DamageType.Type = DamageType.Type.PHYSICAL
var level: int = 1


func _init(
	p_type: Type = Type.MELEE,
) -> void:
	type = p_type


func _apply_type_defaults() -> void:
	match type:
		Type.MAGE:
			display_name = "Goblin Mage"
			damage = 15.0
			hp = 60.0
			has_mana = true
			mana = 100.0
			damage_type = DamageType.Type.MAGICAL

		Type.MELEE:
			display_name = "Goblin Melee"
			damage = 10.0
			hp = 120.0
			has_mana = false
			mana = 0.0
			damage_type = DamageType.Type.PHYSICAL

		Type.RANGE:
			display_name = "Goblin Ranger"
			damage = 8.0
			hp = 80.0
			has_mana = false
			mana = 0.0
			damage_type = DamageType.Type.PHYSICAL


func with_level(
	value: int,
) -> GoblinEnemy:
	level = max(value, 1)

	damage *= level
	hp *= level

	return self
