class_name Knife
extends CharacterBody2D

enum State { IDLE, MOVING, MOVING_AWAY }

const SPEED: float = 4500.0
const SPEED_AWAY: float = 1450.0
const AWAY_ROTATION: float = 4 * PI

var state: State = State.IDLE
var point_of_collision: Vector2 = Vector2.DOWN


func _physics_process(delta: float) -> void:
	match state:
		State.IDLE:
			pass

		State.MOVING:
			var collision: KinematicCollision2D = move_and_collide(Vector2.UP * SPEED * delta)

			if collision:
				var collider: Object = collision.get_collider()

				if collider is DefaultTarget:
					self.reparent(collider.items_container, true)

					state = State.IDLE
				if collider is Knife:
					point_of_collision = collision.get_normal()

					state = State.MOVING_AWAY

		State.MOVING_AWAY:
			rotation += AWAY_ROTATION * delta
			position += point_of_collision * SPEED_AWAY * delta


func throw() -> void:
	state = State.MOVING
