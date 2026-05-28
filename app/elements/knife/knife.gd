extends CharacterBody2D

var speed: float = 4500.0
var is_moving: bool = false


func _physics_process(delta: float) -> void:
	if is_moving:
		var collision: KinematicCollision2D = move_and_collide(Vector2.UP * speed * delta)
		if collision:
			var collider: Object = collision.get_collider()
			if collider is DefaultTarget:
				self.reparent(collider.items_container, true)
				is_moving = false


func throw() -> void:
	is_moving = true
