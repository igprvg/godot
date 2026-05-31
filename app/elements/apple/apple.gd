class_name Apple
extends Node2D

var is_hited: bool = false


func _on_area_2d_body_entered(_body: Node2D) -> void:
	if not is_hited:
		is_hited = true
		queue_free()
