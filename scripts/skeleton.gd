extends Node2D

@export var speed: float = 200.0
@export var target_scene_name: String = "Castle"
@export var stop_distance: float = 10.0
@export var castle_damage: int = 100

var closest_target: Node2D = null

func _ready():
	closest_target = find_first_target(target_scene_name)
 
func _process(delta):
	if closest_target:
		if abs(global_position.x -  closest_target.global_position.x) > stop_distance:
			var direction = (closest_target.global_position - global_position).normalized()
			
			global_position.x += direction.x * speed * delta
			

func find_first_target(scene_name: String) -> Node2D:
	for node in get_tree().get_current_scene().get_children():
		if node.name == scene_name:
			return node

	return null

func get_castle_damage() -> int:
	return castle_damage
	
