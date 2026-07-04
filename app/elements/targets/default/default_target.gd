class_name DefaultTarget
extends CharacterBody2D

const ITEM_WIDTH: float = PI / 6
const APPLE_POSITION: Vector2 = Vector2(0, 170)
const KNIFE_POSITION: Vector2 = Vector2(0, 185)
const MAX_ATTEMPTS: int = 10

@export var apple_spawn_count: int = 3
@export var knife_spawn_count: int = 3

var speed: float = PI
var items_positions: Array[float] = []

var knife_scene: PackedScene = preload("res://app/elements/knife/knife.tscn")
var apple_scene: PackedScene = preload("res://app/elements/apple/apple.tscn")

@onready var items_container: Node2D = $ItemsContainer


func _physics_process(delta: float) -> void:
	rotation += speed * delta


func is_entered_in_items_positions(item_position: float, rng_position: float) -> bool:
	var half_item_width: float = ITEM_WIDTH / 2

	return (
		rng_position >= item_position - half_item_width
		&& rng_position <= item_position + half_item_width
	)


func add_random_item_position(current_attempt: int = 0) -> void:
	if current_attempt >= MAX_ATTEMPTS:
		return

	var current_rng_position = Globals.rng.randf_range(0, 2 * PI)

	var is_found: bool = items_positions.any(
		func(item_position: float) -> bool:
			return is_entered_in_items_positions(item_position, current_rng_position)
	)

	if is_found:
		add_random_item_position(current_attempt + 1)
		return

	items_positions.push_back(current_rng_position)


func reset_items_positions() -> void:
	items_positions.clear()


func spawn_items(item_scene: PackedScene, item_scene_position: Vector2) -> void:
	for _spawn_step in range(apple_spawn_count):
		add_random_item_position()

	for item_position in items_positions:
		var item: Node = item_scene.instantiate()
		items_container.add_child(item)
		item.position = item_scene_position.rotated(item_position)
		item.rotation = item_position

	reset_items_positions()


func _ready() -> void:
	spawn_items(apple_scene, APPLE_POSITION)
	spawn_items(knife_scene, KNIFE_POSITION)
