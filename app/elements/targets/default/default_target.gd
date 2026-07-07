class_name DefaultTarget
extends CharacterBody2D

const SPEED: float = PI
const ITEM_WIDTH: float = PI / 6
const APPLE_POSITION: Vector2 = Vector2(0, 170)
const KNIFE_POSITION: Vector2 = Vector2(0, 185)
const MAX_ATTEMPTS: int = 10

@export var apple_spawn_count: int = 3
@export var knife_spawn_count: int = 3

var knife_scene: PackedScene = preload("res://app/elements/knife/knife.tscn")
var apple_scene: PackedScene = preload("res://app/elements/apple/apple.tscn")

@onready var self_sprite: Sprite2D = $Sprite2D
@onready var items_container: Node2D = $ItemsContainer
@onready var cpu_particles_container: Array[CPUParticles2D] = [
	$KnifeParticles2D,
	$DefaultTargetParticles2DLeft,
	$DefaultTargetParticles2DRight,
	$DefaultTargetParticles2DBottom
]


func _physics_process(delta: float) -> void:
	rotation += SPEED * delta


func is_entered_in_items_positions(item_position: float, rng_position: float) -> bool:
	return rng_position >= item_position - ITEM_WIDTH && rng_position <= item_position + ITEM_WIDTH


func add_random_item_position(items_positions: Array[float], current_attempt: int = 0) -> Variant:
	if current_attempt >= MAX_ATTEMPTS:
		return null

	var current_rng_position = Globals.rng.randf_range(0, 2 * PI)

	var is_found: bool = items_positions.any(
		func(item_position: float) -> bool:
			return is_entered_in_items_positions(item_position, current_rng_position)
	)

	if is_found:
		return add_random_item_position(items_positions, current_attempt + 1)

	return current_rng_position


func collect_random_positions(count: int, occupied_positions: Array[float]) -> Array[float]:
	var positions: Array[float] = []

	for _i in range(count):
		var new_position = add_random_item_position(occupied_positions)

		if new_position != null:
			positions.push_back(new_position)
			occupied_positions.push_back(new_position)

	return positions


func add_items_to_container(
	items_positions: Array[float], item_scene: PackedScene, item_scene_position: Vector2
) -> void:
	for item_position in items_positions:
		var item: Node = item_scene.instantiate()
		items_container.add_child(item)
		item.position = item_scene_position.rotated(item_position)
		item.rotation = item_position


func spawn_items() -> void:
	var occupied_positions: Array[float] = []

	var apple_positions: Array[float] = collect_random_positions(
		apple_spawn_count, occupied_positions
	)
	var knife_positions: Array[float] = collect_random_positions(
		knife_spawn_count, occupied_positions
	)

	add_items_to_container(apple_positions, apple_scene, APPLE_POSITION)
	add_items_to_container(knife_positions, knife_scene, KNIFE_POSITION)


func explode() -> void:
	var tween: Tween = create_tween()

	items_container.hide()
	self_sprite.hide()

	for cpu_particle in cpu_particles_container:
		cpu_particle.emitting = true
		tween.parallel().tween_property(cpu_particle, "modulate:a", 0, 1.0)


func _ready() -> void:
	spawn_items()

	await get_tree().create_timer(5.0).timeout
	explode()
