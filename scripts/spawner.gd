extends Node2D

@export var spawnable: PackedScene

var timer = 0.0
var path: Path2D = null

func _ready():
	path = find_first_path2d_node()
	
	if spawnable == null:
		return

func _process(delta):
	timer += delta
	
	if timer >= 1.0:
		spawn_object()
		timer = 0.0

func spawn_object():
	var obj_instance = spawnable.instantiate()
	obj_instance.path = path
	obj_instance.global_position = global_position
	get_tree().get_current_scene().add_child(obj_instance)

func find_first_path2d_node() -> Path2D:
	var path_nodes = get_tree().get_nodes_in_group("Path")
	
	for node in path_nodes:
		if node is Path2D:
			return node as Path2D
	
	return null 
