extends Node2D

var knife_scene: PackedScene = preload("res://app/elements/knife/knife.tscn")

@onready var knife: CharacterBody2D = $Knife
@onready var timer: Timer = $Timer


func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch && event.is_pressed() && timer.is_stopped():
		knife.throw()
		timer.start()


func _create_knife() -> void:
	knife = knife_scene.instantiate()
	add_child(knife)


func _on_timer_timeout() -> void:
	_create_knife()
