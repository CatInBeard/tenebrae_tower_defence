extends Enemy


func _on_area_2d_area_entered(area: Area2D) -> void:
	print_debug(area)
	if area.get_parent().is_in_group("Bullets"):
		damage(area.get_parent())
