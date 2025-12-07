extends Node2D

class_name SelectArea

func _ready() -> void:
	add_to_group("UI_select")

func can_build() -> bool:
	return true

func is_free() -> bool:
	return true
	
func get_available_build() -> Array:
	return [
		preload("res://scenes/towers/archer_tower.tscn")
	]
