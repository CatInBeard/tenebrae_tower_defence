extends Node2D

@export var health: int = 1000
@export var maxHealth: int = 1000

func take_damage(damage: int):
	health -= damage

func _on_area_2d_area_entered(area: Area2D) -> void:
	var body = area.get_parent()
	if body.has_method("get_castle_damage") and body.get_castle_damage():
		take_damage(body.get_castle_damage())
		body.queue_free()
