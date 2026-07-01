class_name DefaultTarget
extends CharacterBody2D

const ITEM_MARGIN: float = PI / 6
const APPLE_POSITION: Vector2 = Vector2(0, 170)
const MAX_DEPTH: int = 10

@export var apple_spawn_count: int = 3

var speed: float = PI
var current_rng_position: float = 0.0
var current_rng_position_step: int = 0
var items_positions: Array[float] = []

var knife_scene: PackedScene = preload("res://app/elements/knife/knife.tscn")
var apple_scene: PackedScene = preload("res://app/elements/apple/apple.tscn")

@onready var items_container: Node2D = $ItemsContainer


func _physics_process(delta: float) -> void:
	rotation += speed * delta


func is_entered_in_items_positions(item_position: float) -> bool:
	return (
		current_rng_position >= item_position - ITEM_MARGIN / 2
		&& current_rng_position <= item_position + ITEM_MARGIN / 2
	)


func add_random_item_position() -> void:
	if current_rng_position_step >= MAX_DEPTH:
		return

	current_rng_position = Globals.rng.randf_range(0, 2 * PI)

	if items_positions.any(is_entered_in_items_positions):
		current_rng_position_step += 1
		add_random_item_position()
		return

	items_positions.push_back(current_rng_position)
	current_rng_position_step = 0


func reset_items_positions() -> void:
	items_positions.clear()


func spawn_apple() -> void:
	for _spawn_step in range(apple_spawn_count):
		add_random_item_position()

	for item_position in items_positions:
		var apple: Apple = apple_scene.instantiate()
		items_container.add_child(apple)
		apple.position = APPLE_POSITION.rotated(item_position)
		apple.rotation = item_position

	reset_items_positions()


func _ready() -> void:
	spawn_apple()
