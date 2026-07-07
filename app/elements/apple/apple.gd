class_name Apple
extends Node2D

@onready var self_sprite: Sprite2D = $Sprite2D
@onready var cpu_particles_container: Array[CPUParticles2D] = [
	$AppleParticles2DLeft,
	$AppleParticles2DRight,
]


func _on_area_2d_body_entered(collider: Node2D) -> void:
	if collider is Knife:
		var tween: Tween = create_tween()

		self_sprite.hide()

		for cpu_particle in cpu_particles_container:
			cpu_particle.emitting = true
			tween.parallel().tween_property(cpu_particle, "modulate:a", 0, 1.0)

		await tween.finished

		queue_free()
