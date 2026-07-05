class_name Knife
extends CharacterBody2D

var speed: float = 4500.0
var speed_away: float = 1450.0

var is_moving: bool = false
var is_moving_away: bool = false

var away_rotation: float = 4 * PI
var point_of_collision: Vector2 = Vector2.DOWN


func _physics_process(delta: float) -> void:
	if is_moving:
		var collision: KinematicCollision2D = move_and_collide(Vector2.UP * speed * delta)

		if collision:
			var collider: Object = collision.get_collider()

			if collider is DefaultTarget:
				self.reparent(collider.items_container, true)

				is_moving = false
			if collider is Knife:
				point_of_collision = collision.get_normal()

				is_moving = false
				is_moving_away = true
	if is_moving_away:
		rotation += away_rotation * delta
		position += point_of_collision * speed_away * delta


func throw() -> void:
	is_moving = true
