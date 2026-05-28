class_name DefaultTarget
extends CharacterBody2D

var speed: float = PI

@onready var items_container: Node2D = $ItemsContainer


func _physics_process(delta: float) -> void:
	rotation += speed * delta
