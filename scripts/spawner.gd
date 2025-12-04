extends Node2D

@export var spawnable: PackedScene

# Таймер для создания объектов
var timer = 0.0

func _ready():
	
	if spawnable == null:
		return

func _process(delta):
	timer += delta
	
	if timer >= 1.0:
		spawn_object()
		timer = 0.0

func spawn_object():
	var obj_instance = spawnable.instantiate()
	obj_instance.global_position = global_position
	get_tree().get_current_scene().add_child(obj_instance)
