extends Node2D

class_name Enemy

@export var castle_damage: int = 100
@export var speed: float = 30.0
@export var target_scene_name: String = "Castle"
@export var maxHealth: int = 100.0
@export var stop_distance: float = 10.0
@export var path: Path2D = null

@onready var health: int = maxHealth
var path_follow: PathFollow2D = null
var t: float = 0.0 

func _ready() -> void:
	add_to_group("Enemies")
	if path:
		path_follow = PathFollow2D.new()
		path.add_child(path_follow)
		

func find_first_target(scene_name: String) -> Node2D:
	for node in get_tree().get_current_scene().get_children():
		if node.name == scene_name:
			return node

	return null

func get_castle_damage() -> int:
	return castle_damage
	
func _process(delta):
	if path_follow:
		path_follow.progress += speed * delta
		position = path_follow.position

func damage(bullet: Bullet):
	health -= bullet.get_damage()
	if health <= 0:
		die()
	bullet.destroy_on_hit()

func _exit_tree():
	if path_follow:
		path_follow.queue_free()			

func die():
	queue_free()
