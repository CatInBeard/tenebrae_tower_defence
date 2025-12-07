extends Node2D

@export var spawnable: PackedScene
@export var spawn_to: Node2D
@export var path: Path2D = null
@export var mob_spawn_delay: float = 1.0

var timer = 0.0

func _ready():
	if path == null:
		return
	
	if spawnable == null:
		return

func _process(delta):
	timer += delta
	
	if timer >= mob_spawn_delay:
		spawn_object()
		timer = 0.0

func spawn_object():
	var obj_instance = spawnable.instantiate()
	obj_instance.path = path
	obj_instance.global_position = global_position
	spawn_to.add_child(obj_instance)
