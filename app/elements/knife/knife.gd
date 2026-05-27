extends CharacterBody2D

var speed: float = 4500.0
var is_moving: bool = false


func _physics_process(delta: float) -> void:
	if is_moving:
		move_and_collide(Vector2.UP * speed * delta)


func throw() -> void:
	is_moving = true
